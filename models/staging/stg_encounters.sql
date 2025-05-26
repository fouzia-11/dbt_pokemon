SELECT
  CAST(pokemon_id AS INT64) AS pokemon_id,
  LOWER(REPLACE(location_area, '-', ' ')) AS location_area_slug,
  location_area,
  LOWER(version) AS game_version,
  LOWER(encounter_method) AS encounter_method,
  SAFE_CAST(min_level AS INT64) AS min_level,
  SAFE_CAST(max_level AS INT64) AS max_level
FROM `keen-bucksaw-459821-v7.pokemon_data.dim_encounters`