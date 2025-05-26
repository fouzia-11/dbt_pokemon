-- models/intermediate/pokemon_data/int_move_stats.sql

SELECT
  pmu.pokemon_id,
  pmu.pokemon_name,
  pm.move_name,
  pm.power,
  pm.accuracy,
  pm.pp,
  pm.priority,
  pm.damage_class,
  pm.move_type
FROM {{ ref('stg_pokemon_moves_used') }} pmu
LEFT JOIN {{ ref('stg_pokemon_moves') }} pm
  ON LOWER(pmu.move_name) = LOWER(pm.move_name)
