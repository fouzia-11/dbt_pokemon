SELECT
  chain_id,
  stage,
  from_species_name,
  to_species_name,
  COALESCE(SAFE_CAST(min_level AS INT64), 0) AS min_level,
  LOWER(trigger) AS trigger_method
FROM {{ ref('stg_pokemon_evolution') }}
