WITH move_candidates AS (
  SELECT
    link.pokemon_id,
    m.move_name,
    m.power,
    m.move_type
  FROM {{ ref('stg_pokemon_move_links') }} link
  JOIN {{ ref('stg_pokemon_moves') }} m
    ON link.move_name = m.move_name
  WHERE m.power IS NOT NULL
)

SELECT
  atk.id AS attacker_id,
  atk.name AS pokemon_name,
  atk_type.type_name AS attacker_type,

  def.id AS defender_id,
  def.name AS defender_name,
  def_type.type_name AS defender_type,

  CASE rel.relation
    WHEN 'double' THEN 2.0
    WHEN 'half' THEN 0.5
    WHEN 'none' THEN 0.0
    ELSE 1.0
  END AS effectiveness_multiplier,

  CASE
    WHEN rel.relation = 'double' THEN 'strong'
    WHEN rel.relation IN ('half', 'none') THEN 'weak'
    ELSE 'neutral'
  END AS matchup_category,

  ARRAY_AGG(moves.move_name ORDER BY moves.power DESC) AS most_effective_moves,
  def_img.card_image_url AS defender_card_image_url

FROM `keen-bucksaw-459821-v7.pokemon_data.dim_pokemon` atk
JOIN {{ ref('stg_pokemon_types') }} atk_type ON atk.id = atk_type.pokemon_id

CROSS JOIN `keen-bucksaw-459821-v7.pokemon_data.dim_pokemon` def
JOIN {{ ref('stg_pokemon_types') }} def_type ON def.id = def_type.pokemon_id

LEFT JOIN {{ ref('stg_type_relations') }} rel
  ON atk_type.type_name = rel.type_name
 AND def_type.type_name = rel.related_type

LEFT JOIN move_candidates moves
  ON moves.pokemon_id = atk.id
 AND moves.move_type = atk_type.type_name
 AND rel.relation = 'double'

LEFT JOIN {{ ref('stg_pokemon') }} def_img
  ON def.id = def_img.id

WHERE rel.relation IS NOT NULL
  AND moves.move_name IS NOT NULL

GROUP BY
  attacker_id, attacker_name, attacker_type,
  defender_id, defender_name, defender_type,
  effectiveness_multiplier, relation, matchup_category, defender_card_image_url
