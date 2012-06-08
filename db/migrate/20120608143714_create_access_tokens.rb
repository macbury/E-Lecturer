class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.integer :user_id, null: false
      t.string :code, null: false
      t.string :name
      t.datetime :expire_at, null: false

      t.timestamps
    end
    add_index :access_tokens, :user_id
  end
end
