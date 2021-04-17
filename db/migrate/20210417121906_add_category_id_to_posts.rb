class AddCategoryIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :way, :integer, null: false, default: 0
  end
end
