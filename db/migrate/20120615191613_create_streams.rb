class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.integer :user_id
      t.integer :lecturer_id
      t.integer :streamable_id
      t.string :streamable_type

      t.timestamps
    end
  end
end
