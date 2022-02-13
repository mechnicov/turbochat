class RoomChannel < ApplicationCable::Channel
  include Turbo::Streams::ActionHelper
  before_subscribe :set_room
  before_unsubscribe :set_room

  def subscribed
    stream_for @room

    if @room.present?
      @room.add_room_online_user(current_user&.id)
      update_online_user_count
      update_user_email
    end
  end

  def unsubscribed
    if @room.present?
      @room.remove_room_online_user(current_user&.id)
      update_online_user_count
      update_user_email
    end
    stop_all_streams
  end

  private

  def set_room
    @room = Room.find_by_title(params[:id])
    @room ||= Room.find_by_id(params[:id])
  end

  def update_online_user_count
    @room.broadcast_update_to(@room, target: "room_#{@room.id}_online_users_count",
                            partial: "rooms/user_online_count",
                            locals: { count: @room.online_room_users_count })
  end

  def update_user_email
    current_user.messages.where(room_id: @room.id).each do |message|
      @room.broadcast_replace_to(@room,
                                target: "message_#{message.id}_email",
                                partial: "messages/user_online_email",
                                locals: { message: message })
    end
  end
end
