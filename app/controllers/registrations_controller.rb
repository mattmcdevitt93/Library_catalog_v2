class RegistrationsController < Devise::RegistrationsController 
	after_action :check_admin, only: [:create]

    # Use callbacks to share common setup or constraints between actions.

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