class AddUniversityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :university, :string
    add_column :users, :picture, :string
  end
end
