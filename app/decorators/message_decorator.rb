class MessageDecorator < ApplicationDecorator
  delegate_all

  def heart(user)
    if object.likes.find_by(user: user).present?
      "🧡"
    else
      "🤍"
    end
  end

  def likes_count
    object.likes_count if object.likes_count.positive?
  end
end
