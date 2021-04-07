class RemoveDueDateFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :due_date, :date
  end
end
