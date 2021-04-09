class Post < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_many :comments
  has_many :favorites, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000 }
  validates :experience, presence: true, length: { maximum: 20 }
  validates :detail, length: { maximum: 150 }

  def tax
    (price * 1.1).floor.to_s(:delimited)
  end

  def same_favorite(user)
    Favorite.find_by(user_id: user.id, post_id: id)
  end
end
