FactoryGirl.define do
  factory :alcohol do
    trait :primary do
      is_primary true
    end

    factory :vodka, traits: [:primary] do
      name "Vodka"
      proof 40
      search_terms ['vodka']
    end

    factory :brandy, traits: [:primary] do
      name "Brandy"
      proof 40
      search_terms ['brandy', 'cognac']
    end

    factory :weird_alcohol do
      name "Prune Juice"
      proof 1
    end
  end
end
