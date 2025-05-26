
SELECT
  id AS pokemon_id,
  SAFE_CAST(JSON_EXTRACT_SCALAR(stat, '$.base_stat') AS INT64) AS base_stat,
  SAFE_CAST(JSON_EXTRACT_SCALAR(stat, '$.effort') AS INT64) AS effort,
  JSON_EXTRACT_SCALAR(stat, '$.stat.name') AS stat_name,
  JSON_EXTRACT_SCALAR(stat, '$.stat.url') AS stat_url

FROM `keen-bucksaw-459821-v7.pokemon_data.dim_pokemon`,
UNNEST(JSON_EXTRACT_ARRAY(stats)) AS stat
