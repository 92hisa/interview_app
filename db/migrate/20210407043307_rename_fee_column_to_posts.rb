class RenameFeeColumnToPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :fee, :price
  end
end
