class UpgradeFriendship < ActiveRecord::Migration
  def change
    remove_column :friendships, :friend_id
    remove_column :friendships, :user_id
    
    add_column :friendships, :lecturer_id, :integer, null: false
    add_column :friendships, :student_id, :integer, null: false
  end
end
