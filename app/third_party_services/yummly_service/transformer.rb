require 'phys/units'

module YummlyService
  class Ingredient < Struct.new(:quant, :unit, :food)
    INGREDIENT_SPLITTER = /(?<quant>[\w\W]+)\s(?<unit>(cup|ounce|tsp|teaspoon|tablespoon|oz)[^\s]*)\s(?<ingredient>[\w\W]*)/i
    NO_UNIT_SPLITTER = /(?<quant>[\d]+)\s(?<ingredient>[\w\W]*)/i
    def blank?
      quant.nil? || unit.nil? || food.nil?
    end

    def self.blank(input)
      Ingredient.new(nil, nil, nil)
    end

    def unit_value
      Phys::Quantity[self.quant, self.unit].want("floz")
    end

    def self.from_line(input)
      match = INGREDIENT_SPLITTER.match(input)
      if match
        Ingredient.new get_line_quantity(match["quant"]), get_unit(match["unit"]), match["ingredient"]
      else
        match = NO_UNIT_SPLITTER.match(input)
        if match
          Ingredient.new get_line_quantity(match["quant"]), "WHOLE", match["ingredient"]
        else
          Ingredient.blank input
        end
      end
    end

    private
    def self.get_line_quantity(input)
      input.split().collect(&:to_frac).reduce(&:+)
    end

    def self.get_unit(input)
      case input.downcase
        when /ounce/
          "floz"
        else
          input.downcase
      end
    end
  end

  module Transformer
    extend self
    def call(recipe_hash)
      recipe = Yummly::Recipe.new(recipe_hash.with_indifferent_access)
      {
        name: recipe.name,
        calories: get_calories(recipe),
        instructions: recipe.ingredient_lines,
        instructions_attributes: get_instructions(recipe),
        alcohols: get_alcohols(recipe),
        source: "yummly",
        source_id: recipe.id,
        attribution_url: recipe.attribution.url,
        attribution_text: recipe.attribution.text,
        attribution_html: recipe.attribution.html,
        photos_attributes: get_photos(recipe),
        proof: get_proof(recipe),
        girliness: -1,
      }
    end

    def map_ingredients(line)
      YummlyService::Ingredient.from_line(line)
    end

    def get_calories(recipe)
      recipe.nutrition_estimates.find{|ne|ne.attribute == "ENERC_KCAL"}.try(:value)
    end

    def get_alcohols(recipe)
      alcohols = Alcohol.all.pluck(:name).to_a
      alcohols.inject([]) do |acc, alcohol|
        acc  << alcohol if recipe.ingredient_lines.any?{|line| /#{alcohol}/i =~ line }
      end
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

    def get_proof(recipe)

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
