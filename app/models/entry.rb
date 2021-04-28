class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :dm_room

  validates :user_id, presence: true
  validates :dm_room_id, presence: true
end
