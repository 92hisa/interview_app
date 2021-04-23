class CreateDmRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :dm_rooms do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
