FactoryGirl.define do
  factory :blueberry_lemon_fizz do |drink|

    drink.after_create do |drink|
      %i(vodka blueberries lemon mint italian_soda).each do |ingredient_factory|
        FactoryGirl.create "#{ingredient_factory.to_s}_ingredient", drink: drink
      end
    end
  end
end
