-- models/staging/pokemon_data/stg_pokemon_species.sql

SELECT
  pokemon_id,
  LOWER(name) AS species_name,
  description,
  `order`,
  SAFE_CAST(gender_rate AS INT64) AS gender_rate,
  SAFE_CAST(capture_rate AS INT64) AS capture_rate,
  SAFE_CAST(base_happiness AS INT64) AS base_happiness,
  is_baby,
  is_legendary,
  is_mythical,
  SAFE_CAST(hatch_counter AS INT64) AS hatch_counter,
  has_gender_differences,
  forms_switchable,
  LOWER(growth_rate) AS growth_rate,
  JSON_EXTRACT_ARRAY(egg_groups) AS egg_groups_json,
  JSON_EXTRACT_ARRAY(pokedex_numbers) AS pokedex_numbers_json,
  LOWER(color) AS color,
  LOWER(shape) AS shape,
  LOWER(evolves_from_species) AS evolves_from,
  SAFE_CAST(evolution_chain_id AS INT64) AS evolution_chain_id,
  LOWER(habitat) AS habitat,
  LOWER(generation) AS generation
FROM `keen-bucksaw-459821-v7.pokemon_data.dim_species`
