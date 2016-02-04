class ChatMessagesController < ApplicationController
  expose(:chat_message)

  def create
    @chat_message = ChatMessage.new(message_params)
    if @chat_message.save
      flash[:notice] = "success"
    else
      flash[:danger] = "failure"
    end
    redirect_to :back
  end

  private

  def message_params
    params.require(:chat_message).permit(:chat_id, :content).merge(author_id: current_user.id)
  end
end
