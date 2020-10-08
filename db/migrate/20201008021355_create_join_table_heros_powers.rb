class CreateJoinTableHerosPowers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :heros, :powers do |t|
      # t.index [:hero_id, :power_id]
      # t.index [:power_id, :hero_id]
    end
  end
end
