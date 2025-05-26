
SELECT
  id AS location_area_id,
  name AS api_name,
  LOWER(REPLACE(name, '-', ' ')) AS name_slug,
  localized_name,
  SAFE_CAST(game_index AS INT64) AS game_index,
  LOWER(location) AS location_name,  -- to match with stg_pokemon_location.api_name
  SAFE_CAST(encounter_methods AS INT64) AS num_encounter_methods,
  SAFE_CAST(num_encounters AS INT64) AS num_encounters
FROM `keen-bucksaw-459821-v7.pokemon_data.dim_location_area`
