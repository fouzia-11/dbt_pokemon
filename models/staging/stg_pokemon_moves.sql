
SELECT
  id AS move_id,
  LOWER(name) AS move_name,
  SAFE_CAST(accuracy AS FLOAT64) AS accuracy,
  SAFE_CAST(effect_chance AS FLOAT64) AS effect_chance,
  SAFE_CAST(pp AS INT64) AS pp,
  SAFE_CAST(priority AS INT64) AS priority,
  SAFE_CAST(power AS FLOAT64) AS power,
  LOWER(type) AS move_type,
  LOWER(damage_class) AS damage_class,
  LOWER(target) AS target_scope,
  LOWER(generation) AS generation_name,
  short_effect
FROM `keen-bucksaw-459821-v7.pokemon_data.dim_moves`
