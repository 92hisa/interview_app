class RenameMessageColumnToNotifications < ActiveRecord::Migration[6.0]
  def change
    rename_column :notifications, :message_id, :dm_id
  end
end
