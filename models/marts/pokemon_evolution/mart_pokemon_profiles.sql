WITH primary_abilities AS (
  SELECT
    pokemon_id,
    ability_name,
    ROW_NUMBER() OVER (PARTITION BY pokemon_id ORDER BY slot ASC) AS rn
  FROM {{ ref('stg_pokemon_abilities') }}
  WHERE is_hidden = FALSE
),

typed_profiles AS (
  SELECT
    t.pokemon_id,
    ARRAY_AGG(t.type_name ORDER BY t.slot) AS types
  FROM {{ ref('stg_pokemon_types') }} t
  GROUP BY t.pokemon_id
),

stat_pivot AS (
  SELECT
    pokemon_id,
    MAX(CASE WHEN stat_name = 'hp' THEN base_stat END) AS hp,
    MAX(CASE WHEN stat_name = 'attack' THEN base_stat END) AS attack,
    MAX(CASE WHEN stat_name = 'defense' THEN base_stat END) AS defense,
    MAX(CASE WHEN stat_name = 'speed' THEN base_stat END) AS speed
  FROM {{ ref('stg_pokemon_stats') }}
  GROUP BY pokemon_id
)

SELECT
  p.id AS pokemon_id,
  p.name AS pokemon_name,

  ROUND(p.weight / 10.0, 1) AS weight_kg,
  ROUND(p.height / 10.0, 1) AS height_m,

  COALESCE(s.shape, 'Unknown') AS category,
  a.ability_name AS primary_ability,
  tp.types,
  s.description,
  p.card_image_url,

  -- 🎯 Base Stats
  st.hp,
  st.attack,
  st.defense,
  st.speed

FROM {{ ref('stg_pokemon') }} p
LEFT JOIN {{ ref('stg_pokemon_species') }} s
  ON p.id = s.pokemon_id

LEFT JOIN primary_abilities a
  ON p.id = a.pokemon_id AND a.rn = 1

LEFT JOIN typed_profiles tp
  ON p.id = tp.pokemon_id

LEFT JOIN stat_pivot st
  ON p.id = st.pokemon_id
