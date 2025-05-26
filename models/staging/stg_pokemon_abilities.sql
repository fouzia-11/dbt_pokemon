
SELECT
  id AS pokemon_id,
  JSON_EXTRACT_SCALAR(ability, '$.ability.name') AS ability_name,
  JSON_EXTRACT_SCALAR(ability, '$.ability.url') AS ability_url,
  SAFE_CAST(JSON_EXTRACT_SCALAR(ability, '$.slot') AS INT64) AS slot,
  SAFE_CAST(JSON_EXTRACT_SCALAR(ability, '$.is_hidden') AS BOOL) AS is_hidden

FROM `keen-bucksaw-459821-v7.pokemon_data.dim_pokemon`,
UNNEST(JSON_EXTRACT_ARRAY(abilities)) AS ability
