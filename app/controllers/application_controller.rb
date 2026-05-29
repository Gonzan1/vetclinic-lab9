class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  stale_when_importmap_changes
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # --- INICIO CONFIGURACIÓN PUNDIT ---
  include Pundit::Authorization

  # Corrección para Rails 7.1: Usamos lambdas para evitar el error de "Unknown action"
  after_action :verify_authorized, unless: -> { action_name == 'index' || devise_controller? }
  after_action :verify_policy_scoped, if: -> { action_name == 'index' && !devise_controller? }

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # --- FIN CONFIGURACIÓN PUNDIT ---

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end 