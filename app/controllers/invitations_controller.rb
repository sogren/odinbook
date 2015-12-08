class InvitationsController < ApplicationController
	def send_invite
		@inv = current_user.sent_invitations.build(invited_user: User.find(user_id_params))
		if @inv.save
			flash[:notice] = "You succesfully invited user!"
			redirect_to :back
		else
			flash[:danger] = "You cannot invite this user!"
			redirect_to :back
		end
	end

	private

		def invite_check
			
		end

		def user_id_params
			params.require(:user_id)
		end
end
