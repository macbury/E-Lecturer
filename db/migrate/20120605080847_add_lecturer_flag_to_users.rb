class AddLecturerFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lecturer, :boolean, default: false
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :screen_name, :string
    add_column :users, :phone, :string
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
  end
end
