class MessageController < ApplicationController
  def show
    @chat = Chat.find(params[:chat])
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

    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages[params[:message_id].to_i]
    @user = User.find(params[:user_id])
    if !@message.users.include?(@user)
      @message.users << @user
      if @message.save



      end
    end
    respond_to do |format|
      format.js
    end
    sync_update @message, scope: @chat, partial: 'newmessages'



  end

  def updateall

    @chat = Chat.find(params[:chat_id])
    @messages = Message.where(:chat_id => params[:chat_id])
    @lastmessage = current_user.messages.where(:chat_id => params[:chat_id]).last
    @unload = @messages.where(:id => params[:message_id].to_i+1..Message.last.id)
    #sync_new @unload.first, scope: @chat, partial: 'newmessages'

    if !@lastmessage

      @unread = @messages.where(:id => 1..params[:message_id].to_i)
      @unread.each do |message|
        message.users << current_user
        message.save
        sync_update message, scope: @chat, partial: 'newmessages'
      end
    elsif @lastmessage.id < params[:message_id].to_i
      @unread = @messages.where(:id => @lastmessage.id+1..params[:message_id].to_i)
      @unread.each do |message|
        message.users << current_user
        message.save
        sync_update message, scope: @chat, partial: 'newmessages'

      end
    end
    respond_to do |format|
      format.js
    end
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
