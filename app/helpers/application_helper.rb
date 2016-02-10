module ApplicationHelper
  def require_login
    return true if user_signed_in?
    flash[:danger] = "You cannot go there! First sign in or sign up!"
    redirect_to root_path
  end

  def authorization(user)
    unless authorized(user)
      flash[:danger] = "This page is private!"
      redirect_to root_path
    end
  end

  def authorized(user)
    if user_signed_in?
      current_user.is_friend?(user) || current_user == user || user.public?
    else
      user.public?
    end
  end

  def mutual_friends(user)
    current_user.user_friends & user.user_friends
  end

  def user_liked?(object)
    object.likes.map(&:liker_id).include?(current_user.id)
  end

  def friend_button(user)
    if current_user.is_friend?(user)
      info_msg("This user is your friend", "Manage your friends")
    elsif current_user.is_invited_by?(user)
      info_msg("This user sent you an invitation", "Manage your invitations")
    elsif current_user.invited?(user)
      info_msg("You already sent an invitation", "Manage your invitations")
    else
      content_tag(:p, (link_to "Send friend request to this user", send_invite_path(
        inv_user_id: user), method: "post", class: 'people_link'))
    end
  end

  def info_msg(msg, msg2)
    content_tag(:p, msg) +
      content_tag(:p, (link_to msg2, people_path, class: 'people_link'))
  end
end
