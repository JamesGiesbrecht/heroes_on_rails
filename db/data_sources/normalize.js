const fs = require('fs')
const csv = require('csvtojson')

const superheroesApiJson = require('./raw/superhero-api.json')
const heroesCsvPath = __dirname + '/raw/heroes_information.csv'
const powersCsvPath = __dirname + '/raw/super_hero_powers.csv'
/**
 * Nulls represented as null
 *
 * 1. Loop through JSON file
 * 2. Copy desired attributes to new master object
 * 3. If any desired attributes are missing, check heroes CSV
 * 4. Search powers CSV for hero and add powers as an array to hero. Null if hero is not in the sheet
 * 5. Loop through heroes CSV checking if hero already exists
 * 6. Repeat steps 2 + 4 for CSV heroes
 * 7. Export to JSON
 */

const superheroes = []

const run = async () => {
  const heroesConverted = await csv().fromFile(heroesCsvPath)
  const powersConverted = await csv().fromFile(powersCsvPath)
  const powers = {}
  // Creates an array containing of string for each heroes power
  powersConverted.forEach((hero) => powers[hero.hero_names] = Object.keys(hero).filter((power) => hero[power] === 'TRUE'))
}

run()
