
SELECT
  id AS pokemon_id,
  SAFE_CAST(JSON_EXTRACT_SCALAR(type, '$.slot') AS INT64) AS slot,
  JSON_EXTRACT_SCALAR(type, '$.type.name') AS type_name,
  JSON_EXTRACT_SCALAR(type, '$.type.url') AS type_url

FROM `keen-bucksaw-459821-v7.pokemon_data.dim_pokemon`,
UNNEST(JSON_EXTRACT_ARRAY(types)) AS type
