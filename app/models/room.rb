class Room < ApplicationRecord
  belongs_to :purchase
  has_many :messages
end
