class ChatsController < ApplicationController
  expose(:chats) { current_user.all_chats }
  expose(:chat) { Chat.includes(:participant, chat_messages: [:author]).find(params[:id]) }
  expose(:new_chat_message) { ChatMessage.new }

  def show

  end

  def index

  end
end
