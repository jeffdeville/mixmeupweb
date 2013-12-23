FactoryGirl.define do
  factory :yummly_recipe, class: Yummly::Recipe do
    ignore do
      id "123"
      description "description"
      images []
      ingredient_lines ["1 tbsp cinnamon"]
    end

    initialize_with{
      new({
        id: id,
        description: description,
        images: images,
        ingredient_lines: ingredient_lines
      })
    }
  end
end
