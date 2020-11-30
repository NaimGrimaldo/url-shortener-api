# frozen_string_literal: true

class CreateVisitorAgents < ActiveRecord::Migration[6.0]
  def change
    create_table :visitor_agents do |t|
      t.string :agent
      t.string :os
      t.references :visitor, null: false, foreign_key: true
      t.integer :visits, default: 0
      t.datetime :visited_at
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
