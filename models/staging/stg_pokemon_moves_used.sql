SELECT
  id AS pokemon_id,
  name AS pokemon_name,
  JSON_EXTRACT_SCALAR(move, '$.move.name') AS move_name
FROM `keen-bucksaw-459821-v7.pokemon_data.dim_pokemon`,
UNNEST(JSON_EXTRACT_ARRAY(moves)) AS move