
WITH double_damage AS (
  SELECT
    type_name,
    LOWER(JSON_EXTRACT_SCALAR(d, '$')) AS related_type,
    'double' AS relation
  FROM `keen-bucksaw-459821-v7.pokemon_data.raw_type_relations`,
  UNNEST(JSON_EXTRACT_ARRAY(double_damage_to)) AS d
),

half_damage AS (
  SELECT
    type_name,
    LOWER(JSON_EXTRACT_SCALAR(d, '$')) AS related_type,
    'half' AS relation
  FROM `keen-bucksaw-459821-v7.pokemon_data.raw_type_relations`,
  UNNEST(JSON_EXTRACT_ARRAY(half_damage_to)) AS d
),

no_damage AS (
  SELECT
    type_name,
    LOWER(JSON_EXTRACT_SCALAR(d, '$')) AS related_type,
    'none' AS relation
  FROM `keen-bucksaw-459821-v7.pokemon_data.raw_type_relations`,
  UNNEST(JSON_EXTRACT_ARRAY(no_damage_to)) AS d
)

SELECT * FROM double_damage
UNION ALL
SELECT * FROM half_damage
UNION ALL
SELECT * FROM no_damage
