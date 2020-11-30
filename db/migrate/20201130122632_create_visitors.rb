# frozen_string_literal: true

class CreateVisitors < ActiveRecord::Migration[6.0]
  def change
    create_table :visitors do |t|
      t.references :link, null: false, foreign_key: true
      t.string :ip
      t.integer :visitor_kind, default: 0
      t.integer :visits, default: 0
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
