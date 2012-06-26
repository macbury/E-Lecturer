class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.string :action_key
      t.text :message
      t.string :notifiable_type, null: false
      t.string :notifiable_id, null: false

      t.timestamps
    end
  end
end
