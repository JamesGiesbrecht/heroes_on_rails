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
// Example object finished
const superman = {
  name: 'Superman',
  powerStats: {
    intelligence: 94,
    strength: 100,
    speed: 100,
    durability: 100,
    power: 100,
    combat: 85
  },
  powers: [
    'Agility',
    'Accelerated Healing',
    'Cold Resistance',
    'Durability',
    'Energy Absorption',
    'Flight',
    'Marksmanship',
    'Longevity',
    'Intelligence',
    'Super Strength',
    'Stamina',
    'Super Speed',
    'Enhanced Senses',
    'Energy Beams',
    'Jump',
    'Enhanced Memory',
    'Reflexes',
    'Invulnerability',
    'Fire Resistance',
    'Enhanced Hearing',
    'Hypnokinesis',
    'Enhanced Sight',
    'Heat Resistance',
    'Enhanced Smell',
    'Vision - Telescopic',
    'Vision - Microscopic',
    'Super Breath',
    'Vision - Heat',
    'Vision - X-Ray'
  ],
  appearance: {
    gender: 'Male',
    race: 'Kryptonian',
    heightInches: '75',
    weightPounds: '225',
    eyeColor: 'Blue',
    hairColor: 'Black'
  },
  biography: {
    fullName: 'Clark Kent',
    aliases: [
      'Clark Joseph Kent',
      'The Man of Steel',
      'the Man of Tomorrow',
      'the Last Son of Krypton',
      'Big Blue',
      'the Metropolis Marvel',
      'the Action Ace'
    ],
    placeOfBirth: 'Krypton',
    publisher: 'DC Comics',
    alignment: 'good'
  },
  images: {
    'xs': 'https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/xs/644-superman.jpg',
    'sm': 'https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/sm/644-superman.jpg',
    'md': 'https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/md/644-superman.jpg',
    'lg': 'https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/644-superman.jpg'
  }
}

// Example csv
const heroesCSV = {
  id: '98',
  name: 'Black Cat',
  Gender: 'Female',
  'Eye color': 'green',
  Race: 'Human',
  'Hair color': 'Blond',
  Height: '178',
  Publisher: 'Marvel Comics',
  'Skin color': '-',
  Alignment: 'good',
  Weight: '54'
}

// Example powers csv
const zoom = [
  'Super Speed',
  'Intangibility',
  'Time Travel',
  'Time Manipulation'
]

const checkForNull = (firstProperty, secondProperty) => {
  if (!firstProperty || firstProperty === '-' ) {
    if (!secondProperty || secondProperty === '-') {
      return null
    }
    return secondProperty
  }
  if (Array.isArray(firstProperty) && (!firstProperty[0] || firstProperty[0] === '-')) return []
  return firstProperty
}

const removeUnits = (str) => {
  const num = str.split(' ')[0]
  return ['0', '-99', '-', null, undefined].includes(num) ? null : num
}

const centimetersToInches = (centimeters) => {
  centimeters = removeUnits(centimeters)
  return centimeters ? Math.round(centimeters * 0.392701) : null
}

const kgsToPounds = (kgs) => {
  kgs = removeUnits(kgs)
  return kgs ? Math.round(kgs * 2.20462) : null
}

const run = async () => {
  const heroesConverted = await csv().fromFile(heroesCsvPath)
  const powersConverted = await csv().fromFile(powersCsvPath)
  const powers = {}
  // Creates an array of strings for each heroes power
  powersConverted.forEach((hero) => powers[hero.hero_names.toLowerCase()] = Object.keys(hero).filter((power) => hero[power] === 'TRUE'))

  //  Running through JSON heroes
  const jsonHeroes = superheroesApiJson.map((hero) => {
    // Splice will remove an item from an array and return the removed item
    const heroIndex = heroesConverted.findIndex((hero) => hero.name === hero.name)
    let csvHero = heroIndex !== 1 ? heroesConverted.splice(heroIndex, 1)[0] : null
    return {
      name: hero.name,
      powerStats: hero.powerstats,
      powers: powers[hero.name.toLowerCase()] || [],
      appearance: {
        gender: checkForNull(hero.appearance.gender, csvHero.Gender),
        race: checkForNull(hero.appearance.race, csvHero.Race),
        heightIn: centimetersToInches(hero.appearance.height[1]) || centimetersToInches(csvHero.Height),
        weightLb: kgsToPounds(hero.appearance.weight[1]) || kgsToPounds(csvHero.Weight),
        eyeColor: checkForNull(hero.appearance.eyeColor, csvHero['Eye color']),
        hairColor: checkForNull(hero.appearance.hairColor, csvHero['Hair color']),
      },
      biography: {
        fullName: checkForNull(hero.biography.fullName),
        aliases: checkForNull(hero.biography.aliases),
        placeOfBirth: checkForNull(hero.biography.placeOfBirth),
        publisher: checkForNull(hero.biography.publisher, csvHero.Publisher),
        alignment: checkForNull(hero.biography.alignment, csvHero.Alignment),
      },
      images: hero.images,
    }
  })

  // Running through remaining CSV heroes
  const csvHeroes = heroesConverted.map((hero) => ({
      name: hero.name,
      powerStats: {},
      powers: powers[hero.name.toLowerCase()] || [],
      appearance: {
        gender: checkForNull(hero.Gender),
        race: checkForNull(hero.Race),
        heightIn: centimetersToInches(hero.Height),
        weightLb: kgsToPounds(hero.Weight),
        eyeColor: checkForNull(hero['Eye color']),
        hairColor: checkForNull(hero['Hair color']),
      },
      biography: {
        fullName: null,
        aliases: [],
        placeOfBirth: null,
        publisher: checkForNull(hero.Publisher),
        alignment: checkForNull(hero.Alignment),
      },
      images: {},
  }))

  fs.writeFileSync(__dirname + '/normalized/heroes.json', JSON.stringify(jsonHeroes.concat(csvHeroes)), 'utf-8')
}

run()
