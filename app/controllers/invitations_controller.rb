class InvitationsController < ApplicationController
	def send_invite
		@inv = current_user.sent_invitations.build(invited_user_id: invite_params, status: "pending")
		if @inv.save
			flash[:info] = "You succesfully invited user!"
		else
			flash[:danger] = "You cannot invite this user!"
		end
		redirect_to people_path
	end

	def remove_invite
		@inv = current_user.sent_invitations.find_by(invited_user_id: invite_params, status: "pending" )
		if @inv.destroy
			flash[:info] = "invitation removed"
		else
			flash[:danger] = "couldnt find invite"
		end
		redirect_to people_path
	end

	def decline_invite
		@inv = current_user.received_invitations.find_by(invited_user_id: invite_params, status: "pending" )
		if @inv
			@inv.update(status: "declined")
			flash[:info] = "invitation declined"
		else
			flash[:danger] = "couldnt find invite"
		end
		redirect_to people_path
	end

	private

		def invite_check
			
		end

		def invite_params
			params.require(:inv_user_id)
		end
end
