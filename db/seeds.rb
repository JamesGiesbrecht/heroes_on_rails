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
  publisher = Publisher.find_or_create_by(name: hero['biography']['publisher'])
  race = Race.find_or_create_by(race: hero['appearance']['race'])
  Hero.create(
    name: hero['name'],
    fullName: hero['biography']['fullName'],
    gender: hero['appearance']['gender'],
    height: hero['appearance']['heightIn'].to_i,
    weight: hero['appearance']['weightLb'].to_i,
    eye_color: hero['appearance']['eyeColor'],
    hair_color: hero['appearance']['hairColor'],
    place_of_birth: hero['biography']['placeOfBirth'],
    alignment: hero['biography']['alignment']
  )
end
pp Hero.take(2)
pp Publisher.take(2)
pp Race.take(2)
