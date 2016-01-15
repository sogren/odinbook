class InvitationsController < ApplicationController
  def send_invite
    @inv = current_user.sent_invitations.build(invite_params)
    if @inv.save
      flash[:info] = 'You succesfully invited user!'
    else
      flash[:danger] = 'You cannot invite this user!'
    end
    redirect_to people_path
  end

  def remove_invite
    @inv = current_user.sent_invitations.find_by(invite_params)
    if @inv.destroy
      flash[:info] = 'invitation removed'
    else
      flash[:danger] = 'couldnt find invite'
    end
    redirect_to people_path
  end

  def decline_invite
    @inv = current_user.received_invitations.find_by(decline_invite_params)
    if @inv
      @inv.update(status: 'declined')
      flash[:info] = 'invitation declined'
    else
      flash[:danger] = 'couldnt find invite'
    end
    redirect_to people_path
  end

   private

  def invite_params
    { invited_user_id: params[:inv_user_id], status: 'pending' }
  end

  def decline_invite_params
    { inviting_user_id: params[:inv_user_id], status: 'pending' }
  end
end
