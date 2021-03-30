class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :title, null: false
      t.integer :fee, null: false
      t.date :due_date, null: false
      t.string :experience, null: false
      t.text :detail
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
