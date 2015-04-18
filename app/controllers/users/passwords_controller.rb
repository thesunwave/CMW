class Users::PasswordsController < Devise::PasswordsController
  before_filter :show_main_forms!, :except => [:new]
  layout "layouts/auth"


  def new
    super
  end

  # POST /resource/password
  def create
    self.resource = resource_class.new
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?
    
    if successfully_sent?(resource)
      return
    else
      return
    end
  end

  # PUT /resource/password
  def update
    if params[:user].blank? || params[:user][:reset_password_token].blank?
      return
    end
    
    self.resource = resource_class.new
    resource.reset_password_token = params[:user][:reset_password_token]
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if resource.confirmed?
        sign_in(resource_name, resource)
        return
      else
        return
      end
    else
      return
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