class ChatMessagesController < ApplicationController
  expose(:chat_message, attributes: :message_params)

  def create
    chat_message.author = current_user
    unless chat_message.save
      render nothing: true
    end
  end

  private

  def message_params
    params.require(:chat_message).permit(:chat_id, :content)
  end
end
