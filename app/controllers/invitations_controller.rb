class InvitationsController < ApplicationController
	def send_invite
		@inv = current_user.sent_invitations.build(invited_user: User.find(user_id_params))
		if @inv.save
			flash[:notice] = "You succesfully invited user!"
		else
			flash[:danger] = "You cannot invite this user!"
		end
		redirect_to :back
	end

	def accept_invite
		
	end

	def remove_invite
		
	end

	def decline_invite
		
	end

	private

		def invite_check
			
		end

		def user_id_params
			params.require(:user_id)
		end
end
