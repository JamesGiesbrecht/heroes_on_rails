# frozen_string_literal: true

class AddPublisherIdToHeros < ActiveRecord::Migration[6.0]
  def change
    add_column :heros, :publisher_id, :integer
    add_index :heros, :publisher_id
  end
end
