class MessageController < ApplicationController
  def show
    @chat = Chat.find(params[:chat])
    @chat_side = current_user.chats.where(:team_id => params[:team])
    @whiteboard = @chat.whiteboard
    @message = current_user.messages.where(:chat_id => @chat.id).last
    @team = @chat.team
    if !@chat.users.include?(current_user)
      redirect_to :root
    end
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
  def imageup
    @message = Message.new(:messagetype => 1, :chat_id => params[:chat_id], :sender_id => current_user.id)
    @imagemessage = Imagemessage.new(:imagemessageupload => params[:image_file], :chat_id => params[:chat_id])
    @chat = Chat.find(params[:chat_id])
    if @imagemessage.save
      @message.imagemessage = @imagemessage
      @message.save
      sync_new @message, scope: @chat, partial: 'newmessages'
      #sync_new @imagemessage, scope: @chat
      respond_to do |format|
        format.js
      end

    end
  end

  def fileup
    @message = Message.new(:messagetype => 2, :chat_id => params[:chat_id], :sender_id => current_user.id)
    @filemessage = Filemessage.new(:filemessageupload => params[:file_file], :chat_id => params[:chat_id])
    @chat = Chat.find(params[:chat_id])
    if @filemessage.filemessageupload && @filemessage.save
      @message.filemessage = @filemessage
      @message.save
      sync_new @message, scope: @chat, partial: 'newmessages'
      #sync_new @imagemessage, scope: @chat
      respond_to do |format|
        format.js
      end

    end
  end


  private
    def message_params
      params.require(:message).permit(:content, :chat_id)
    end
end
