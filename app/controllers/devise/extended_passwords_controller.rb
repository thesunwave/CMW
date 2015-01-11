class Devise::ExtendedPasswordsController < Devise::PasswordsController

  # POST /resource/password
  def create
    self.resource = resource_class.new
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?
    
    if successfully_sent?(resource)
      render json: { result: 1 } and return
    else
      render json: { error_key: 'invalid_form', errors: resource.errors.as_json }, status: :unprocessable_entity and return
    end
  end

  # PUT /resource/password
  def update
    if params[:user].blank? || params[:user][:reset_password_token].blank?
      render json: { error_key: 'invalid_form', errors: { reset_password_token: [ t('errors.messages.blank') ] } }, status: :unprocessable_entity and return
    end
    
    self.resource = resource_class.new
    resource.reset_password_token = params[:user][:reset_password_token]
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if resource.confirmed?
        sign_in(resource_name, resource)
        render json: { result: 1, confirmed: 1 } and return
      else
        render json: { result: 1, confirmed: 0 } and return
      end
    else
      render json: { error_key: 'invalid_form', errors: resource.errors.as_json }, status: :unprocessable_entity and return
    end
  end

  # resource init moved to 'update' action for code consistency
  def edit
  end

protected
    # disable redirect
    def after_resetting_password_path_for(resource)
    end

    # disable redirect
    def after_sending_reset_password_instructions_path_for(resource_name)
    end

    # disable redirect
    def require_no_authentication
    end

    # disable redirect
    def assert_reset_token_passed
    end

end