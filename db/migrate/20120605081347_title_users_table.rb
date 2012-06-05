class TitleUsersTable < ActiveRecord::Migration
  def change  
    create_table :titles_users, id: false do |t|
      t.integer :user_id
      t.integer :title_id
    end
  end

end
