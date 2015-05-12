class ApplicationController < ActionController::Base
  # turn devise to json
  respond_to :html, :json

  before_action :authenticate_user!

  # set locale in session or/and store it in db
  before_filter :set_locale

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    render json: { error_key: 'invalid_token' }, status: :unprocessable_entity
  end

  def require_user
    access_denied('You must be logged in to do that!') unless current_user
  end

   def access_denied(message = 'Access Denied')
    if request.xhr?
      render :text => message, :status => :unauthorized
    else
      flash[:error] = message
      redirect_to new_user_session_path
    end
    return false
  end

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :lang, :terms_of_service)}
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation)}
  end

private

  def set_locale
    # сохранить локаль в сессии
    session[:locale] = http_accept_language.compatible_language_from(I18n.available_locales) if session[:locale].blank?
    # если пользователь авторизован
    if user_signed_in?
      # если у пользователя не сохранен язык в БД, сохраняем
      current_user.update_attributes(lang: session[:locale].to_s) if current_user.lang.blank?
      # если у пользователя сохранен язык, используем его
      session[:locale] = current_user.lang.to_sym unless current_user.lang.blank?
    end
    I18n.locale = session[:locale]
  end

  def show_main_forms!
    if user_signed_in?
      redirect_to root_path
    end
  end

end
