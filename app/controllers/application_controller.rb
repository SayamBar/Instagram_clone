class ApplicationController < ActionController::Base
    before_action :authenticate_user!
#     before_action :doorkeeper_authorize!
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

         def configure_permitted_parameters
              devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :website, :bio, :gender)}

              devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :avatar, :password, :current_password, :website, :bio, :gender)}
         end
end
