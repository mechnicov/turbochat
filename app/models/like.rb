class Like < ApplicationRecord
  belongs_to :message, counter_cache: true
  belongs_to :user
end
