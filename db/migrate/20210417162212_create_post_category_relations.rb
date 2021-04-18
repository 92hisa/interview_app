class CreatePostCategoryRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :post_category_relations do |t|
      t.references :post, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
