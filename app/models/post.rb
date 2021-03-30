class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :fee, presence: true
  validates :due_date, presence: true
  validates :experience, presence: true
end
