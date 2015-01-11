class Devise::ExtendedSessionsController < Devise::SessionsController
  
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?

    user_roles = []
    resource.roles.each do |role|
      user_roles.push(role.name)
    end
    render json: { result: 1, user: resource.as_json.merge({ roles: user_roles.as_json }) } and return
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    yield resource if block_given?
    
    render json: { result: (signed_out) ? 1 : 0 } and return
  end

protected
  # disable redirect
  def require_no_authentication
  end

  # disable redirect
  def after_sign_in_path_for(resource)
  end

private
  def respond_to_on_destroy
    render json: { result: 0 } and return
  end

end
