require 'spec_helper'

describe YummlyService::Extracter do
  describe ".find_drinks_with" do
    before {
      VCR.use_cassette('yummly', record: :new_episodes) do
        @recipes = YummlyService::Extracter.find_drinks_with(alcohol: 'vodka')
      end
    }

    it "should have loaded all of the recipes from yummly with vodka" do
      expect(@recipes.length).to be >= 50
      expect(@recipes).to have_ingredients
      expect(@recipes).to have_ids
      expect(@recipes).to have_pictures
    end
  end


  describe '.get', focus: :true do
    shared_examples_for "get recipe" do
      before {
        VCR.use_cassette('yummly_get', record: :new_episodes) do
          @recipe = YummlyService::Extracter.get(id)
        end
      }

      it "should load the recipe in its entirety" do
        expect(@recipe).to have_ingredient_lines
        expect(@recipe).to have_recipe_pictures
        expect(@recipe).to have_yield
        expect(@recipe).to have_rating
        expect(@recipe).to have_attribution
      end
    end

    VCR.use_cassette('yummly', record: :new_episodes) do
      @recipe_ids = YummlyService::Extracter.find_drinks_with(alcohol: 'vodka').sample(10).map{|r| r["id"] }
    end

    @recipe_ids.each do |recipe_id|
      it_should_behave_like "get recipe" do
        let(:id) { recipe_id }
      end
    end
  end
end
