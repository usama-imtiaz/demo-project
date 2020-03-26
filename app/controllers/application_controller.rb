class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	
	
	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :phone, :password_confirmation, :tax_id, :address, :image, :bio) }
		devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :password_confirmation, :phone, :tax_id, :address, :image, :bio) }
	end
end
