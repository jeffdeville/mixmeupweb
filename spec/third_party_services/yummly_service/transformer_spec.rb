require 'spec_helper'

describe YummlyService::Transformer do
  RSpec::Matchers.define :have_calories do
    match do |recipe_hash|
      recipe_hash[:calories].to_i == recipe_hash[:calories] && recipe_hash[:calories] > 0
    end
  end

  RSpec::Matchers.define :have_name do |name|
    match do |recipe_hash|
      recipe_hash[:name].present? && recipe_hash[:name] == name
    end
  end

  RSpec::Matchers.define :have_instructions do |name|
    match do |recipe_hash|
      recipe_hash[:instructions].length > 0
    end
  end

  RSpec::Matchers.define :have_alcohols do |name|
    match do |recipe_hash|
      recipe_hash[:alcohols].length > 0
    end
  end

  RSpec::Matchers.define :have_attribution do
    match do |recipe_hash|
      (recipe_hash.keys & keys) == keys
    end

    failure_message_for_should do |recipe_hash|
      "RecipeHash should have included keys: #{keys.inspect} but was missing #{keys - (keys & recipe_hash.keys)}"
    end

    def keys
      %i(source source_id attribution_url attribution_text attribution_html)
    end
  end

  RSpec::Matchers.define :have_photos do
    match do |recipe_hash|
      photos = get_photos(recipe_hash)
      get_photos(recipe_hash).present? &&
        get_photos(recipe_hash).all?{|photo| get_photo_versions(photo).count == 3 }

    end

    failure_message_for_should do |recipe_hash|
      if get_photos(recipe_hash).empty?
        "No photos included"
      else
        "Photos did not include all of #{%i(type url)}. Photos: #{get_photos(recipe_hash)}"
      end
    end

    def get_photos(recipe_hash)
      recipe_hash.fetch(:photos_attributes, [])
    end

    def get_photo_versions(photo_versions_hash)
      photo_versions_hash.fetch(:photo_versions_attributes, [])
    end
  end


  describe ".call" do
    before {
      Alcohol.create(name: 'vodka', is_primary: true)
    }

    let(:yummly_hash) {
      {
        id: 123,
        description: "description",
        name: "name",
        ingredientLines: [
          "vodka line 1",
          "berries line 2",
        ],
        nutritionEstimates:[
          {"attribute" => "ENERC_KCAL","description" => "Energy","value" => 400,"unit" => {"id" => "fea252f8-9888-4365-b005-e2c63ed3a776","name" => "calorie","abbreviation" => "kcal","plural" => "calories","pluralAbbreviation" => "kcal"}}
        ],
        attribution:{
          html: "<a href=''http://www.yummly.com/recipe/Limoncello-II-AllRecipes''>Limoncello II recipe</a> information powered by <img alt=''Yummly'' src=''http://static.yummly.com/api-logo.png''/>",
          url: "http://www.yummly.com/recipe/Limoncello-II-AllRecipes",
          text: "Limoncello II recipes: information powered by Yummly"
        },
        images:[
          {
            imageUrlsBySize: {
              "90" => "http://lh6.ggpht.com/zM1pnIS5cjUr-D0nNkvEWuMUxmWw1uJ9ZtlMcTuK7wCztJPslK_tDAFjJPvGwrQNTyjJdQREPwnfDbXIsAHd=s90-c",
              "360" => "http://lh6.ggpht.com/zM1pnIS5cjUr-D0nNkvEWuMUxmWw1uJ9ZtlMcTuK7wCztJPslK_tDAFjJPvGwrQNTyjJdQREPwnfDbXIsAHd=s360-c"
            },
            hostedLargeUrl: "http://i.yummly.com/Limoncello-II-AllRecipes-78937.l.png",
            hostedSmallUrl:"http://i.yummly.com/Limoncello-II-AllRecipes-78937.s.png"
          }
        ]
      }
    }

    let!(:recipe_attributes) { subject.call(yummly_hash) }

    it "should have mapped the attributes correctly" do
      expect(recipe_attributes).to have_calories
      expect(recipe_attributes).to have_name("name")
      expect(recipe_attributes).to have_instructions
      expect(recipe_attributes).to have_alcohols
      expect(recipe_attributes).to have_attribution
      expect(recipe_attributes).to have_photos
      expect(recipe_attributes).to have_proof
      expect(recipe_attributes).to have_girliness
    end
  end
  # describe ".map_ingredients" do
  #   RSpec::Matchers.define :extract_components_from do |ingredient_line|
  #     match do |service|
  #       ingredient = map_to_ingredient(service, ingredient_line)
  #       !ingredient.blank? || ingredient_line =~ /ice/i
  #     end

  #     failure_message_for_should do |service|
  #       ingredient = map_to_ingredient(service, ingredient_line)
  #       "Missing Components mapping line: '#{ingredient_line}'.  Got Name: #{ingredient.food} Units: #{ingredient.unit} Quantity: #{ingredient.quant}"
  #     end

  #     def map_to_ingredient(service, ingredient_line)
  #       service.map_ingredients(ingredient_line)
  #     end
  #   end


  #   @lines = File.read("spec/third_party_services/yummly_service/ingredient_lines.txt").split("\n")
  #   @lines.each do |ingredient_line|
  #     it "should map #{ingredient_line}" do
  #       expect(YummlyService::Transformer).to extract_components_from(ingredient_line)
  #     end
  #   end

  # end
end
