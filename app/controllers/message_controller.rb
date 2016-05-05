class MessageController < ApplicationController
  def show
    @chat = Chat.find(params[:chat])
    @whiteboard = @chat.whiteboard
    @message = current_user.messages.where(:chat_id => @chat.id).last
    @team = @chat.team
  end

  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id
    @message.chat = Chat.find(params[:message][:chat_id])
    @chat = @message.chat
    if @message.save
      sync_new @message, scope: @chat, partial: 'newmessages'
      respond_to do |format|
        format.js
      end
    end
  end
  def update
    @message = Message.find(params[:messageid])
    @message.users << current_user
    @message.save

  end
  private
  def message_params
    params.require(:message).permit(:content, :chat_id)
  end
end
