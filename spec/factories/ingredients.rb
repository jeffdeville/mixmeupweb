FactoryGirl.define do
  factory :ingredient do
    trait :as_floz do
      units 'floz'
    end
    trait :as_tbsp do
      units 'tbsp'
    end

    factory :vodka_ingredient do
      units "floz"
      quantity 4
      name "vodka"

      trait :with_alcohol do
        after(:create) do |ingredient|
          ingredient.alcohol = FactoryGirl.create :vodka
          ingredient.save!
        end
      end
    end

    factory :blueberries_ingredient do
      units "cup"
      quantity 0.5
      name "fresh blueberries"
    end

    factory :lemon_ingredient do
      units "whole"
      quantity 1
      name "lemon (thinly sliced and seeds removed)"
    end

    factory :mint_ingredient do
      units "whole"
      quantity "4"
      name "mint (sprigs)"
    end

    factory :italian_soda_ingredient do
      name "soda (italian, whatever fruity flavor you like!)"
    end

    factory :boiling_water_ingredient do
      units "cup"
      quantity 1
      name "boiling water"
    end

    factory :tea_ingredient do
      quantity 3
      name "Lipton® Bavarian Wild Berry Pyramid Tea Bags"
    end

    factory :sugar_ingredient do
      units "Tbsp"
      quantity 2
      name "sugar"
    end

    factory :pomegranate_juice_ingredient do
      units "Tbsp"
      quantity 2
      name "pomegranate juice"
    end

    factory :lime_juice_ingredient do
      units "Tbsp"
      quantity 1
      name "lime juice"
    end

    factory :orange_liqueur_ingredient do
      units "Tbsp"
      quantity 1
      name "orange liqueur"

      trait :with_alcohol do
        after(:create) do |ingredient|
          ingredient.alcohol = FactoryGirl.create :orange_liqueur
          ingredient.save!
        end
      end
    end
  end
end
