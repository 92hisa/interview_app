class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  validates :message, presence: true
  validates :user_id, presence: true
  validates :room_id, presence: true

  after_create_commit { MessageBroadcastJob.perform_later self }
end
