class MessagesController < ApplicationController
  def create
    @new_message = current_user.messages.build(strong_params)

    if @new_message.save
      @new_message.broadcast_append_to @new_message.room, locals: { user: current_user }
    end
  end

  private

  def strong_params
    params.require(:message).permit(:body, :room_id)
  end
end
