class AddMyExperienceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :my_experience, :text
  end
end
