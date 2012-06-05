class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name
      t.integer :city_id, null: false
      t.string :permalink

      t.timestamps
    end

    add_index :universities, :city_id
  end
end
