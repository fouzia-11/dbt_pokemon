WITH defender_profiles AS (
  SELECT
    id AS defender_id,
    name AS defender_name,
    card_image_url AS defender_card_image_url
  FROM {{ ref('stg_pokemon') }}
)

SELECT
  prof.pokemon_id,
  prof.pokemon_name,
  prof.card_image_url AS attacker_card_image_url,
  prof.height_m,
  prof.weight_kg,
  prof.types,
  prof.primary_ability,
  prof.category,
  prof.description,

  match.defender_id,
  def.defender_name,
  match.defender_type,
  def.defender_card_image_url,
  match.effectiveness_multiplier,
  match.matchup_category,
  match.most_effective_moves

FROM {{ ref('mart_pokemon_profiles') }} prof
LEFT JOIN {{ ref('mart_pokemon_matchups') }} match
  ON prof.pokemon_id = match.attacker_id
LEFT JOIN defender_profiles def
  ON match.defender_id = def.defender_id
