module UsersHelper
  def user_name_link(user)
    link_to user.full_name, timeline_path(user)
  end
end
