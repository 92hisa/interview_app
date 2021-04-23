class AddDmRoomIdToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :dm_room_id, :integer
  end
end
