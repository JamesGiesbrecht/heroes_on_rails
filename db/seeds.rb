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

heroes.each do |h|
  publisher = Publisher.find_or_create_by(name: h['biography']['publisher'])
  race = Race.find_or_create_by(race: h['appearance']['race'])
  hero = Hero.new(
    name: h['name'],
    fullName: h['biography']['fullName'],
    gender: h['appearance']['gender'],
    height: h['appearance']['heightIn'].to_i,
    weight: h['appearance']['weightLb'].to_i,
    eye_color: h['appearance']['eyeColor'],
    hair_color: h['appearance']['hairColor'],
    place_of_birth: h['biography']['placeOfBirth'],
    alignment: h['biography']['alignment']
  )
  h['powers'].each do |power|
    power = Power.find_or_create_by(name: power)
  end
  hero.save
end
pp Hero.take(2)
pp Publisher.take(2)
pp Race.take(2)
pp Power.take(2)
