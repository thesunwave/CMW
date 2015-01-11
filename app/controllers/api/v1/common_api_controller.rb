class Api::V1::CommonApiController < Api::BaseApiController
  before_action :authenticate_user!, only: [:check_username]

  # проверка наличия почты в БД
  #     если почты нет в БД   -> возвращает 1
  #     если почта есть в БД  -> возвращает 0
  def check_email
    unless params[:email].blank?
      render json: { result: (User.find_by_email(params[:email])) ? 0 : 1 } and return
    else
      render json: { error_key: 'invalid_data', errors: { email: t('errors.messages.blank') } }, status: :unprocessable_entity and return
    end
  end

  # проверка валидности username
  #     если валидно    -> возвращает 1
  #     если не валидно -> возвращает 0
  def check_username
    unless params[:username].blank?     
      render json: { result: (User.valid_username?(params[:username])) ? 1 : 0 } and return
    else
      render json: { error_key: 'invalid_data', errors: { username: t('errors.messages.blank') } }, status: :unprocessable_entity and return
    end
  end

  # Сменить язык системы
  def switch_locale
    if !params[:locale].blank?
      if I18n.available_locales.include?(params[:locale].to_sym)
        # сохранить текущий язык в БД и/или сессии
        current_user.update_attributes(lang: params[:locale]) if user_signed_in?
        I18n.locale = session[:locale] = params[:locale].to_sym
      else
        flash[:alert] = 'locale not exist'
      end
      # перенаправить пользователя туда, откуда он пришел
      redirect_to (params[:redirect_to].blank?) ? root_path : '/'+params[:redirect_to]
    else
      # перенаправить в корень, если указана неверная локаль
      redirect_to root_path
    end
  end

  # возвращает массив строк в текущей локали
  def get_locale
    render json: I18n.t('angular') and return
  end

end