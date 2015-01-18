class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?
  before_filter :show_main_forms!, only: [:new, :create]
  before_filter :instantiateUser, only: [:new, :create, :update]
  
  def new
    render layout: "login"
  end

  # POST /resource
  # Регистрация нового пользователя
  def create
    super
    build_resource(sign_up_params)

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)

        # refactor: DRY in sessions and registratios
        user_roles = []
        resource.roles.each do |role|
          user_roles.push(role.name)
        end
        return
      else
        expire_data_after_sign_in!
        render text: "#{resource.inactive_message}"
        return
      end
    else
      clean_up_passwords resource
      # respond_with resource
    end
  end

  def cancel
    super
  end

  # PUT /resource
  # Обновление настроек пользователя
  # Мы используем копию объекта пользователя, так как мы не хотим чтобы
  # объект пользователя менялся сразу без проверок и подтверждений
  def update
    super
    self.resource = resource_class.to_adapter.get!([current_user.id])
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    
    # определяем необходимость наличия текущего пароля:
    # если изменены почта или пароль, текущий пароль обязателен
    needs_password = false
    if account_update_params[:password].present? || account_update_params[:email].present?
      needs_password = true 
    end

    # удалить данные, которые не могут быть обновлены без текущего пароля
    # или вернуть ошибку, если текущеий пароль не предоставлен
    if needs_password
      if account_update_params[:current_password].blank?
        return
      end
    else
      # удалить данные, которые не могу быть обновлены без текущего пароля
      unsafe_props = [:current_password, :password, :password_confirmation, :email]
      unsafe_props.each do |prop|
        account_update_params.delete(prop)
      end
    end

    #
    # уведомления
    #
    # if account_update_params[:notifications].present?
    #   if account_update_params[:notifications].is_a? Hash
    #     # обработать уведомления
    #     account_update_params[:notifications].each do |notification, value|
    #       if value.to_i == 1
    #         current_user.add_notification notification.to_sym
    #       else
    #         current_user.remove_notification notification.to_sym
    #       end
    #     end
    #     # удалить уведомления из объекта обновления настроек
    #     account_update_params.delete(:notifications)
    #   else
    #     # ошибка формата
    #     render json: { error_key: 'invalid_form', errors: { notifications: [t('errors.messages.invalid')] } }, status: :unprocessable_entity and return
    #   end
    # end

    #
    # обновить данные пользователя
    #
    # обновляем в зависимости от того, требуется ли текущий пароль
    if needs_password
      resource_updated = resource.update_with_password(account_update_params)
    else
      resource_updated = resource.update_without_password(account_update_params)
    end
    yield resource if block_given?

    # вернуть результат и применить изменения
    if resource_updated
      needs_confirmation = update_needs_confirmation?(resource, prev_unconfirmed_email) ? 1 : 0
      sign_in resource_name, resource, bypass: true
      # настройки обновлены, флаг needs_confirmation указывает необходимо ли пользователю подтверждать почту
      return
    else
      clean_up_passwords resource
      if resource.errors.blank?
        # ничего не обновлено
        return
      else
        # возникли ошибки
        return
      end
    end
  end

  # установить поля, которые могут придти в запросе
  # если поле придёт в запросе, но его не окажется в этих списках
  # оно не будет доступно в массиве параметров
  def update_sanitized_params
    # на регистрацию
    devise_parameter_sanitizer.for(:sign_up) do |u| 
      u.permit(:email, :password, :password_confirmation, :lang)
    end
    # на обновление настроек
    # в конце указано поле links типом которого должен быть массив
    # данное поле необходимо указывать в коцне
    devise_parameter_sanitizer.for(:account_update) do |u| 
      u.permit(:email, :password, :password_confirmation, 
        :current_password, :lang)
    # devise_parameter_sanitizer.for(:account_update) do |u| 
    #   u.permit(:email, :first_name, :last_name, :password, :password_confirmation, 
    #     :current_password, :city_id, :username, :description, :lang, 
    #     :links => [])
      # .tap do |while_listed|
      #     while_listed[:notifications] = params[:user][:notifications]
      #   end
    end
  end

protected

  #disbale redirect
  def require_no_authentication
  end

  #disbale redirect
  def after_sign_in_path_for(resource)
  end

  #disbale redirect
  def after_inactive_sign_up_path_for(resource)
  end

  #disbale redirect
  def after_sign_up_path_for(resource)
  end

  #disbale redirect
  def after_update_path_for(resource)
  end

end
