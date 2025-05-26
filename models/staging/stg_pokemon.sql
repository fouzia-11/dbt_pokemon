
WITH base AS (
  SELECT
    id,
    name,
    base_experience,
    height,
    is_default,
    `order`,
    weight,
    location_area_encounters,
    card_image_url
  FROM `keen-bucksaw-459821-v7.pokemon_data.dim_pokemon`
)

SELECT * FROM base
