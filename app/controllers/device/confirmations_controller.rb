class Devise::ConfirmationsController < Devise::ConfirmationsController

  # GET /auth/confirm?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      render json: { result: 1 } and return
    else
      render json: { error_key: 'invalid_data', errors: resource.errors.as_json } and return
    end
  end

protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    # new_session_path(resource_name) if is_navigational_format?
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    # if signed_in?(resource_name)
    #   signed_in_root_path(resource)
    # else
    #   new_session_path(resource_name)
    # end
  end

end
