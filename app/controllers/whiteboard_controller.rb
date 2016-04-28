class WhiteboardController < ApplicationController
  def update
    @whiteboard = Whiteboard.find(params[:whiteboardid])
    @whiteboard.content = params[:content]
    @chat = @whiteboard.chat
    @whiteboard.edit = false
    if @whiteboard.save
      @message = Message.new(:content => "Whiteboard has been Changed")
      @message.sender_id = current_user.id
      @message.chat = @whiteboard.chat
      @message.save
      respond_to do |format|
        format.js
      end
      sync_new @message, scope: @chat, partial: 'newmessages'
      sync_update @whiteboard, scope: @chat

    end


  end

  def update2
    @whiteboard = Whiteboard.find(params[:whiteboardid])
    @whiteboard.user = current_user
    if @whiteboard.edit != true
      @whiteboard.edit = true
      if @whiteboard.save
        redirect_to controller: 'message', action: 'show', chat: @whiteboard.chat.id
        sync_update @whiteboard, scope: @chat

      end
    else
      redirect_to controller: 'message', action: 'show', chat: @whiteboard.chat.id
    end

  end
end
