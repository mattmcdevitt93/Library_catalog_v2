class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


	def admin_check
		if current_user.admin == false
			redirect_to :root
		end
	end

	def approval_check
		if current_user.approved == false
			redirect_to :root
		end
	end

	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:account_update, keys: [:admin, :approved])
	end

	def check_admin
    	Rails.logger.info "check_admin"
    	initial_user = User.where(admin: true)
    	if initial_user == []
    		Rails.logger.info "Resetting Admin Permissions"
    		user = User.find(1)
    		user.update(admin: true)
    	end
    end

end
