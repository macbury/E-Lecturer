class AddBasicInfoFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birth_date, :date
  end
end
