class FriendsRelationsController < ApplicationController
  def make_friend
    @inv = current_user.received_invitations.find_by(inviting_user_id: friend_params, status: 'pending')
    if @inv
      @friendship = current_user.friends_relations.build(friend_id: friend_params)
      if @friendship.save
        @inv.update(status: 'accepted')
        flash[:notice] = 'Added as friend!'
      else
        flash[:danger] = 'Unable to add.'
      end
    else
      flash[:danger] = 'There is no invitation like this'
    end
    redirect_to people_path
  end

  def destroy
    @friendship = current_user.all_friends_rels(friend_params)
    @inv = current_user.accepted_invites(friend_params)
    if @friendship && @friendship.destroy && @inv.destroy
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
