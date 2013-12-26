RSpec::Matchers.define :have_third_party_id do |hash_id_field_key|
  match do |food|
    food.with_indifferent_access[:_id] == food.with_indifferent_access[hash_id_field_key]
  end
end
