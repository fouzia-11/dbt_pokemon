SELECT
  species.pokemon_id,
  pokemon.name AS pokemon_name,
  species.is_legendary,
  species.is_mythical,
  species.generation,
  species.egg_groups_json AS egg_groups,
  types.type_name
FROM {{ ref("stg_pokemon") }} pokemon
LEFT JOIN {{ ref('stg_pokemon_species') }} species
  ON pokemon.id = species.pokemon_id
LEFT JOIN {{ ref('stg_pokemon_types') }} types
  ON species.pokemon_id = types.pokemon_id
