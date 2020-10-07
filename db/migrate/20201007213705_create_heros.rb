class CreateHeros < ActiveRecord::Migration[6.0]
  def change
    create_table :heros do |t|
      t.string :name
      t.string :fullName
      t.string :gender
      t.integer :height
      t.integer :weight
      t.string :eye_color
      t.string :hair_color
      t.string :place_of_birth
      t.string :alignment

      t.timestamps
    end
  end
end
