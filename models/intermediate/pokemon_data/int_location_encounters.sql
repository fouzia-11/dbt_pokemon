SELECT
  e.pokemon_id,
  e.location_area_slug,
  e.game_version,
  e.encounter_method,
  e.min_level,
  e.max_level,
  la.location_name
FROM {{ ref('stg_encounters') }} e
LEFT JOIN {{ ref('stg_location_areas') }} la
  ON e.location_area = la.api_name
