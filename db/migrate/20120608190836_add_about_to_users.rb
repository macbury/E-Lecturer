class AddAboutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
    remove_column :users, :twitter
    remove_column :users, :facebook
  end
end
