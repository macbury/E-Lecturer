class AddModeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mode, :integer, default: User::Undefined
    remove_column :users, :lecturer
  end
end
