class Post < ApplicationRecord
  belongs_to :user
  has_many :purchases

  validates :title, presence: true
  validates :fee, presence: true
  validates :due_date, presence: true
  validates :experience, presence: true

  def tax
    (fee * 1.1).floor.to_s(:delimited)
  end
end
