class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :content, null: false
      t.references :saler, null: false, foreign_key: { to_table: :users }
      t.references :buyer, null: false, foreign_key: { to_table: :users }
      t.references :user, foreign_key: true
      t.references :purchase, foreign_key: true
      t.timestamps
    end
  end
end
