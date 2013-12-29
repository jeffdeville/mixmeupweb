FactoryGirl.define do
  factory :drink do
    factory :blueberry_lemon_fizz do
      name "Blueberry Lemon Fizz"
      calories 150
      instructions ["vodka", "blueberries", "lemon", "mint", "italian soda"]
      source "yummly"
      source_id "blueberry_lemon_fizz"

      after(:create) do |drink|
        %i(blueberries lemon mint italian_soda).each do |ingredient_factory|
          FactoryGirl.create("#{ingredient_factory.to_s}_ingredient", drink: drink)
        end

        FactoryGirl.create :vodka_ingredient, :with_alcohol, drink: drink
      end
    end

    factory :bavarian_wild_berry_cosmo do
      name "Bavarian Wild Berry Cosmo"
      calories 130
      instructions [
        "1 cup boiling water",
        "3 Lipton® Bavarian Wild Berry Pyramid Tea Bags",
        "2 Tbsp. sugar",
        "2 Tbsp. pomegranate juice",
        "2 Tbsp. vodka",
        "1 Tbsp. lime juice",
        "1 Tbsp. orange liqueur",
      ]
      source 'yummly'
      source_id 'bavarian_wild_berry_cosmo'

      after(:create) do |drink|
        %i(boiling_water tea sugar pomegranate_juice lime_juice).each do |ingredient_factory|
          FactoryGirl.create "#{ingredient_factory.to_s}_ingredient", drink: drink
        end

        FactoryGirl.create :vodka_ingredient, :with_alcohol, :as_tbsp, quantity: 2, drink: drink
        FactoryGirl.create :orange_liqueur_ingredient, :with_alcohol, :as_tbsp, quantity: 1, drink: drink
      end
    end
  end
end
