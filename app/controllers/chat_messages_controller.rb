class ChatMessagesController < ApplicationController
  expose(:chat_message, attributes: :message_params)

  def create
    if chat_message.save
      flash[:notice] = "success"
    else
      flash[:danger] = "failure"
    end
    render nothing: true
  end

  private

  def message_params
    params.require(:chat_message).permit(:chat_id, :content).merge(author_id: current_user.id)
  end
end
