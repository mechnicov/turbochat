module LikesHelper
  def likes(message)
    heart =
      if message.likes.find_by(user: current_user).present?
        "🧡"
      else
        "🤍"
      end

    heart << " #{message.likes_count}" if message.likes_count.positive?

    heart
  end
end
