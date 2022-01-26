class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :messages, -> { sorted }, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
