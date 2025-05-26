-- models/staging/pokemon_data/stg_pokemon_evolution.sql

SELECT
  chain_id,
  stage,
  LOWER(from_species) AS from_species_name,
  LOWER(to_species) AS to_species_name,
  SAFE_CAST(min_level AS INT64) AS min_level,
  LOWER(trigger) AS trigger,
  LOWER(item) AS evolution_item,
  gender,  -- leave as-is if it's numeric
  LOWER(held_item) AS held_item,
  LOWER(known_move) AS known_move,
  LOWER(known_move_type) AS known_move_type,
  LOWER(location) AS location,
  SAFE_CAST(min_happiness AS INT64) AS min_happiness,
  SAFE_CAST(min_beauty AS INT64) AS min_beauty,
  SAFE_CAST(min_affection AS INT64) AS min_affection,
  needs_overworld_rain,
  LOWER(party_species) AS party_species,
  LOWER(party_type) AS party_type,
  SAFE_CAST(relative_physical_stats AS INT64) AS relative_physical_stats,
  LOWER(time_of_day) AS time_of_day,
  LOWER(trade_species) AS trade_species,
  turn_upside_down
FROM `keen-bucksaw-459821-v7.pokemon_data.dim_evolution`
