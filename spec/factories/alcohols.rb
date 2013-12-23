FactoryGirl.define do
  factory :alcohol do
    trait :primary do
      is_primary true
    end

    factory :vodka, traits: [:primary] do
      name "Vodka"
    end
  end
end
