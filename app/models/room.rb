class Room < ApplicationRecord
  has_many :users
  belongs_to :purchase
end
