module ChatsHelper
  def chat_with(chat)
    return chat.participant.full_name if current_user.chats.include?(chat)
    return chat.user.full_name
  end
end
