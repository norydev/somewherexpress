class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit

  after_action :verify_authorized, except: :index, unless: :devise_or_admin_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_or_admin_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def devise_or_admin_controller?
    devise_controller? || admin_controller?
  end

  def admin_controller?
    is_a?(RailsAdmin::MainController)
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(:back)

    rescue ActionController::RedirectBackError
      redirect_to root_path
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :girl, :email, :password, :password_confirmation) }
    end
end
