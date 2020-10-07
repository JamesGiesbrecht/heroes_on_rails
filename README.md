# Data

## Sources
This project contains a database of roughly 734 superheroes and villains. The data in this project is pulled in from 3 sources.
- An [open source superhero REST API ](https://akabab.github.io/superhero-api/api/) providing a JSON file with in depth hero information.
- A CSV with more basic hero information scraped from https://superherodb.com
- A CSV containing list of powers for each hero, from the [same source as the previous file](https://www.kaggle.com/claudiodavi/superhero-set/home)

The JSON data is more complete so the DB will be based off this and if the data is missing any properties the CSV will be searched. Any heroes that are in the CSV but not the JSON will then also be added to the DB, with as many fields as are available.

The powers CSV will also be parsed and an array of each heroes powers will be added to each entry.

The database will consist of 4 tables
- Heroes
- Powers
- Races
- Publishers

Every hero can have many powers, one race and one publisher
Powers can belong to many heroes
Races can identify many heroes
Publishers can own many heroes

## ER Diagram
![ER Diagram](docs/superheroERD.png)
