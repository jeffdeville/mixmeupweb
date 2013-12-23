RSpec::Matchers.define :have_ingredients do
  match { |recipes| recipes.all? {|recipe| !recipe["ingredients"].blank? } }
end

RSpec::Matchers.define :have_ids do
  match { |recipes| recipes.all?{|recipe| !recipe["id"].blank? } }
end

RSpec::Matchers.define :have_pictures do
  match { |recipes| recipes.all?{|recipe| binding.pry if recipe["imageUrlsBySize"].blank?; recipe["imageUrlsBySize"].count >= 1 } }
end

RSpec::Matchers.define :have_ingredient_lines do
  match {|recipe| recipe.ingredient_lines.count > 1 }
end

RSpec::Matchers.define :have_recipe_pictures do
  match {|recipe| recipe.images.count >= 1 }
end

RSpec::Matchers.define :have_yield do
  match {|recipe| recipe.number_of_servings.present? || recipe.json["yield"].present? }
end

RSpec::Matchers.define :have_rating do
  match {|recipe| recipe.rating.to_i >= 0 && recipe.rating.to_i <= 5 }
end

RSpec::Matchers.define :have_attribution do
  match {|recipe| !recipe.attribution.url.blank? && !recipe.attribution.text.blank? }
end
