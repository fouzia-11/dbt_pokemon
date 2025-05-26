-- models/staging/pokemon_data/stg_pokemon_location.sql

SELECT
  id AS location_id,
  name AS api_name,
  LOWER(REPLACE(name, '-', ' ')) AS name_slug,
  localized_name,
  LOWER(region) AS region,
  SAFE_CAST(game_indices AS INT64) AS game_index_count,
  SAFE_CAST(num_areas AS INT64) AS num_areas
FROM `keen-bucksaw-459821-v7.pokemon_data.dim_location`
