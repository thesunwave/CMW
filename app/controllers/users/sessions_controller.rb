class Users::SessionsController < Devise::SessionsController
  before_filter :show_main_forms!, :except => [:destroy]
  layout "layouts/auth"

  def new
    super
  end

  def create
    super
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    yield resource if block_given?

    user_roles = []
    resource.roles.each do |role|
      user_roles.push(role.name)
    end
    return
  end

  def destroy
    super
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    yield resource if block_given?
    return
  end

protected
  # disable redirect
  def require_no_authentication
  end

  # disable redirect
  def after_sign_in_path_for(resource)
  end

end
