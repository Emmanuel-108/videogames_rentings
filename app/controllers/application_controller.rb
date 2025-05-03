class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?
  before_action :set_pending_requests_count

  private

  def set_pending_requests_count
    if user_signed_in?
      @pending_requests_count = current_user.videogames.sum do |vg|
        vg.bookings.where(status: "pending").count
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number])
  end
end
