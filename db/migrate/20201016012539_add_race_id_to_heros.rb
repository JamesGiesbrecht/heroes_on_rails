# frozen_string_literal: true

class AddRaceIdToHeros < ActiveRecord::Migration[6.0]
  def change
    add_column :heros, :race_id, :integer
    add_index :heros, :race_id
  end
end
