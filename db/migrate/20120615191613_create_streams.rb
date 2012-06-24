class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.integer :lecturer_id, null: false
      t.integer :streamable_id, null: false
      t.string :streamable_type, null: false

      t.timestamps
    end
  end
end
