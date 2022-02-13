class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :messages, -> { sorted }, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [40, 40]
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_commit :add_default_avatar, on: %i[create update]

  def username
    email.split('@').first.parameterize.split('-').join(' ').titlecase # "john.doe@example.com" -> "John Doe"
  end

  def profile_avatar
    avatar.variant(resize_to_limit: [100, 100]).processed
  end

  private

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'Unknowns_user_avatar.png')),
      filename: 'Unknowns_user_avatar.png',
      content_type: 'image/png'
    )
  end
end
