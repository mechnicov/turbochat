class MessagesController < ApplicationController
  def create
    @new_message = current_user.messages.build(strong_params)

    if @new_message.save
      room = @new_message.room
      @new_message.broadcast_append_to room, target: "room_#{room.id}_messages", locals: { user: current_user, message: @new_message.decorate }
    end
  end

  def like
    @message = Message.find(params[:id])
    like = @message.likes.find_by(user: current_user)

    if like.present?
      like.destroy
    else
      @message.likes.create(user: current_user)
    end

    room = @message.room

    @message.broadcast_replace_to [current_user, room], target: "message_like_#{@message.id}", partial: "messages/heart", locals: { user: current_user, message: @message.decorate }
    @message.broadcast_replace_to room, target: "message_likes_count_#{@message.id}", partial: "messages/likes_count", locals: { user: current_user, message: @message.decorate }
  end

  private

  def strong_params
    params.require(:message).permit(:body, :room_id)
  end
end
