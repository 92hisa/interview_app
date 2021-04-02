class Purchase < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User"
  has_one :room, dependent: :destroy
end
