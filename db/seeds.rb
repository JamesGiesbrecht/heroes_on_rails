# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'json'

Hero.destroy_all
Power.destroy_all
Publisher.destroy_all
Race.destroy_all

heroes_data = File.read(Rails.root.join('db/data_sources/normalized/heroes.json'))

heroes = JSON.parse(heroes_data)

heroes.each do |hero|
  puts hero['name']
end
