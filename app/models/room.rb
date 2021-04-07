class Room < ApplicationRecord
  belongs_to :user
  belongs_to :purchase
  has_many :messages
end
