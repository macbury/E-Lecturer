class CreateObservers < ActiveRecord::Migration
  def change
    create_table :observers do |t|
      t.string :observable_type, null: false
      t.integer :observable_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
