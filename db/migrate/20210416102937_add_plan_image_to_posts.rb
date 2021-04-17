class AddPlanImageToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :plan_image, :string
    add_column :posts, :subtitle, :text
  end
end
