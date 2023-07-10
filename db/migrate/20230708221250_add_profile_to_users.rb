class AddProfileToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :introduction, :text
    #add_reference :users, :avatar, null: false, foreign_key: true
  end
end
