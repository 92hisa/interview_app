class CreateDms < ActiveRecord::Migration[6.0]
  def change
    create_table :dms do |t|
      t.references :user, foreign_key: true
      t.references :dm_room, foreign_key: true
      t.text :text, direct_message: false

      t.timestamps
    end
  end
end
