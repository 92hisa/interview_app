class Post < ApplicationRecord
  belongs_to :user
  has_many :purchases

  validates :title, presence: true
  validates :price, presence: true
  validates :experience, presence: true

  def tax
    (price * 1.1).floor.to_s(:delimited)
  end
end
