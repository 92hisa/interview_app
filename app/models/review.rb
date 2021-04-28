class Review < ApplicationRecord
  belongs_to :purchase
  belongs_to :user
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User"

  validates :user_id, presence: true
  validates :saler_id, presence: true
  validates :buyer_id, presence: true
  validates :purchase_id, presence: true
  validates :score, presence: true
  validates :content, presence: true, length: { maximum: 300 }
end
