class Room < ApplicationRecord
  belongs_to :purchase
  has_many :messages

  validates :purchase_id, presence: true
end
