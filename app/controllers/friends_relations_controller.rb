class FriendsRelationsController < ApplicationController
  def make_friend
    @inv = current_user.received_invitations
           .find_by(inviting_user_id: friend_params, status: 'pending')
    @friendship = current_user.friends_relations.build(friend_id: friend_params)
    if @friendship.save && @inv
      @inv.update(status: 'accepted')
      flash[:notice] = 'Added as friend!'
    else
      flash[:danger] = 'Unable to make friendship.'
    end
    redirect_to people_path
  end

  def destroy
    @inv = current_user.accepted_invite(friend_params)
    @friendship = current_user.current_friend_rel(friend_params)
    if @friendship.destroy && @inv.destroy
      flash[:warning] = 'Friend removed.'
    else
      flash[:danger] = 'Unable to remove.'
    end
    redirect_to people_path
  end

   private

  def friend_params
    params.require(:friend_id)
  end
end
