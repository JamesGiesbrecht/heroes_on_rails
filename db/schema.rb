# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_201_016_012_539) do
  create_table 'heros', force: :cascade do |t|
    t.string 'name'
    t.string 'fullName'
    t.string 'gender'
    t.integer 'height'
    t.integer 'weight'
    t.string 'eye_color'
    t.string 'hair_color'
    t.string 'place_of_birth'
    t.string 'alignment'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'publisher_id'
    t.integer 'race_id'
    t.index ['publisher_id'], name: 'index_heros_on_publisher_id'
    t.index ['race_id'], name: 'index_heros_on_race_id'
  end

  create_table 'heros_powers', id: false, force: :cascade do |t|
    t.integer 'hero_id', null: false
    t.integer 'power_id', null: false
  end

  create_table 'powers', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'publishers', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'races', force: :cascade do |t|
    t.string 'race'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end
end
