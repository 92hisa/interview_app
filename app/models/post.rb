class Post < ApplicationRecord
  belongs_to :user
  has_many :purchases

  validates :title, presence: true
  validates :fee, presence: true
  validates :due_date, presence: true
  validates :experience, presence: true
end
