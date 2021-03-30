class AddNameAndGenderAddAboutMeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :gender, :integer, null: false, default: 0
    add_column :users, :about_me, :text
  end
end
