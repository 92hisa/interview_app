class Purchase < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User"
  has_one :room, dependent: :destroy
  has_one :review, dependent: :destroy

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :saler_id, presence: true
  validates :buyer_id, presence: true
end
