class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :messages, -> { sorted }, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [40, 40]
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def username
    # "john.doe@example.com" -> "John Doe"
    email.split('@').first.parameterize.split('-').join(' ').titlecase
  end
end
