
WITH all_types AS (
  SELECT DISTINCT type_name FROM {{ ref('stg_type_relations') }}
  UNION DISTINCT
  SELECT DISTINCT related_type AS type_name FROM {{ ref('stg_type_relations') }}
),

type_matchups AS (
  SELECT
    atk.type_name AS attacker_type,
    def.type_name AS defender_type
  FROM all_types atk
  CROSS JOIN all_types def
),

effectiveness AS (
  SELECT
    type_name AS attacker_type,
    related_type AS defender_type,
    relation
  FROM {{ ref('stg_type_relations') }}
)

SELECT
  tm.attacker_type,
  tm.defender_type,
  CASE
    WHEN eff.relation = 'double' THEN 2.0
    WHEN eff.relation = 'half' THEN 0.5
    WHEN eff.relation = 'none' THEN 0.0
    ELSE 1.0
  END AS effectiveness_multiplier
FROM type_matchups tm
LEFT JOIN effectiveness eff
  ON tm.attacker_type = eff.attacker_type
 AND tm.defender_type = eff.defender_type
