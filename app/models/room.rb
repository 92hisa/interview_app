class Room < ApplicationRecord
  has_many :user_rooms
  has_many :users
  belongs_to :purchase
end
