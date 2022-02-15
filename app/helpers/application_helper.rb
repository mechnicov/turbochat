module ApplicationHelper
  def user_nav_name(user)
    content_tag(:span, user.username, class: "font-bold text-gray-400")
  end

  def room_name(room)
    room.name ||= room.title
  end
end
