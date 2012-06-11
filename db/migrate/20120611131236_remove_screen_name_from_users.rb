class RemoveScreenNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :screen_name
  end
end
