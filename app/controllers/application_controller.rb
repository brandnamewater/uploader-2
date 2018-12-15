class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource


  protected

#  def configure_permitted_parameters
#    devise_parameter_sanitizer.for(:sign_up) << :name
#    devise_parameter_sanitizer.for(:account_update) << :name
#  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end


  private

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == "edit"
      "admin"
    elsif devise_controller? && resource_name == :affiliate && action_name == "edit"
      "affiliate_dashboard"
    elsif devise_controller? && resource_name == :user && action_name == "new"
      "devise_new"
    elsif devise_controller? && resource_name == :affiliate && action_name == "new"
      "devise_new"
    else
      "application"
    end
  end


end
