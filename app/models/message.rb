class Message < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :room

  scope :sorted, -> { order(:id) }

  validates :body, presence: true
end
