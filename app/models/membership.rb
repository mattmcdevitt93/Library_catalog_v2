class Membership < ApplicationRecord
	validates_uniqueness_of :user_id, :scope => [:group_id]
	belongs_to :user
	belongs_to :group

	def self.all_memberships_update()
			user_object = User.all
			user_object.each do |user|
				Membership.user_check(user.id.to_i)
			end
		Rails.logger.info "End ALL check"
	end

	def self.user_memberships_update(user)
		if user == nil
			Rails.logger.info "Nil user"
			return
		else
			Rails.logger.info " User:" + user.to_s
			Membership.user_check(user.to_i)
		end
		Rails.logger.info "End USER check"

	end

	private

	def self.roll_check(user_id, role_id)
		current_role = Membership.where(user_id: user_id, group_id: role_id).first
		role_list = [nil, "admin", "approved"]


		if current_role
			# Rails.logger.info "+ Role Check - " + current_role.user_id.to_s + " | " + current_role.group_id.to_s + " Exists."
			user_role = User.find(user_id)
			if true == eval("user_role." << role_list[role_id.to_i].to_s)
				# No change needed
				Rails.logger.info "No change needed Y "
				return 1
			else
				# Set User role to true
				# account.update(primary_character_name: character.character_name)
				eval("user_role.update(" + role_list[role_id.to_i].to_s + ": true)")
				Rails.logger.info "Set user role to true"
				return 2
			end


		else
			# Rails.logger.info "+ Role Check - " + user_id.to_s + " | " + role_id.to_s + " Does not Exists."
			# Entry does not exist, check if false, otherwise set false
			user_role = User.find(user_id)
			if false == eval("user_role." << role_list[role_id.to_i].to_s)
				# No change needed
				Rails.logger.info "No change needed X "
				return 1
			else
				eval("user_role.update(" + role_list[role_id.to_i].to_s + ": false)")
				# Set user role to false
				Rails.logger.info "Set user role to false"

				return 3
			end
		end
		return 0
	end

	def self.user_check(user_id)
		Rails.logger.info "User Check - " + user_id.to_s
		# Role check all roles of a user and make change
		user_object = User.find(user_id)
		role_list = [1, 2]

		role_list.each do |role|
			Membership.roll_check(user_object.id.to_i, role.to_i)
			# Rails.logger.info "Check: " + check.to_s
		end
	end
end
