FactoryGirl.define do
  factory :ingredient do
    factory :vodka_ingredient do
      units "oz"
      quantity 4
      name "vodka"
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
      units 4
      quantity "whole"
      name "mint (sprigs)"
    end

    factory :italian_soda_ingredient do
      name "soda (italian, whatever fruity flavor you like!)"
    end
  end
end
