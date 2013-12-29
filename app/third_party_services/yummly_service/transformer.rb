module YummlyService
  module Transformer
    extend self
    def call(recipe_hash)
      recipe = Yummly::Recipe.new(recipe_hash.with_indifferent_access)
      {
        name: recipe.name,
        calories: get_calories(recipe),
        instructions: recipe.ingredient_lines,
        ingredients_attributes: get_instructions(recipe),
        source: "yummly",
        source_id: recipe.id,
        attribution_url: recipe.attribution.url,
        attribution_text: recipe.attribution.text,
        attribution_html: recipe.attribution.html,
        photos_attributes: get_photos(recipe),
      }
    end

    def map_ingredients(line)
      YummlyService::Ingredient.from_line(line)
    end

    def get_calories(recipe)
      recipe.nutrition_estimates.find{|ne|ne.attribute == "ENERC_KCAL"}.try(:value)
    end

    def get_photos(recipe)
      recipe.images.map do |image|
        {
          photo_versions_attributes: [
            { height: 60, width: 90, url: image.small_url },
            { height: 120, width: 180, url: image.small_url },
            { height: 240, width: 360, url: image.large_url },
          ]
        }
      end
    end

    def get_instructions(recipe)
      recipe.ingredient_lines.map do |ingredient_line|
        ysi = YummlyService::Ingredient.from_line(ingredient_line)
        {
          units: ysi.unit, quantity: ysi.quant, name: ysi.food
        }
      end
    end
  end
end
