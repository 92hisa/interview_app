class DmRoom < ApplicationRecord
  has_many :dms, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
end
