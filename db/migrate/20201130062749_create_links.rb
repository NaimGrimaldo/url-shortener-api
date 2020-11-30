# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.text :original_url, null: false, length: 2083
      t.references :user, null: false, foreign_key: true
      t.string :unique_key, limit: 10, null: false
      t.integer :visits, null: false, default: 0
      t.datetime :expires_at
      t.datetime :deleted_at, index: true

      t.timestamps
    end

    add_index :links, :unique_key, unique: true
    add_index :links, :original_url, length: 2083
  end
end
