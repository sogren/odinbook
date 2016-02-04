class ChatsController < ApplicationController
  expose(:chats) { current_user.chats }
  expose(:chat)
  expose(:new_chat_message) { ChatMessage.new }
  def create

  end

  def show

  end

  def index

  end

  def destroy

  end
end
