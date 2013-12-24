FactoryGirl.define do
  factory :yummly_recipe, class: Yummly::Recipe do
    ignore do
      id "123"
      description "description"
      images []
      ingredient_lines ["1 tbsp cinnamon"]
      calories 120
    end

    initialize_with{
      new({
        id: id,
        description: description,
        images: images,
        ingredient_lines: ingredient_lines,
        nutritionEstimates:[
          {"attribute" => "ENERC_KCAL","description" => "Energy","value" => calories,"unit" => {"id" => "fea252f8-9888-4365-b005-e2c63ed3a776","name" => "calorie","abbreviation" => "kcal","plural" => "calories","pluralAbbreviation" => "kcal"}}
        ]
      })
    }
  end
end
