class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id, nil: false
      t.integer :friend_id, nil: false

      t.timestamps
    end
  end
end
