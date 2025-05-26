WITH defender_profiles AS (
  SELECT
    id AS defender_id,
    name AS defender_name,
    card_image_url AS defender_card_image_url
  FROM {{ ref('stg_pokemon') }}
),

evolution_chain AS (
  SELECT
    s.evolution_chain_id,
    s.pokemon_id,
    p.name AS pokemon_name,
    p.card_image_url
  FROM {{ ref('stg_pokemon_species') }} s
  JOIN {{ ref('stg_pokemon') }} p
    ON s.pokemon_id = p.id
),

pokemon_with_chain AS (
  SELECT
    s.pokemon_id,
    ARRAY_AGG(STRUCT(ec.pokemon_id, ec.pokemon_name, ec.card_image_url) ORDER BY ec.pokemon_id) AS evolutions
  FROM {{ ref('stg_pokemon_species') }} s
  JOIN evolution_chain ec
    ON s.evolution_chain_id = ec.evolution_chain_id
  GROUP BY s.pokemon_id
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

  chain.evolutions AS evolution_chain,

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
LEFT JOIN pokemon_with_chain chain
  ON prof.pokemon_id = chain.pokemon_id
