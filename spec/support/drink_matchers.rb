RSpec::Matchers.define :have_calories do
  match do |recipe_hash|
    recipe_hash[:calories].to_i == recipe_hash[:calories] && recipe_hash[:calories] > 0
  end
end

RSpec::Matchers.define :have_name do |name|
  match do |recipe_hash|
    recipe_hash[:name].present? && recipe_hash[:name] == name
  end
end

RSpec::Matchers.define :have_instructions do |name|
  match do |recipe_hash|
    recipe_hash[:instructions].length > 0
  end
end

RSpec::Matchers.define :have_alcohols do |name|
  match do |recipe_hash|
    recipe_hash[:alcohols].length > 0
  end
end

RSpec::Matchers.define :have_attribution do
  match do |recipe_hash|
    (recipe_hash.keys & keys) == keys
  end

  failure_message_for_should do |recipe_hash|
    "RecipeHash should have included keys: #{keys.inspect} but was missing #{keys - (keys & recipe_hash.keys)}"
  end

  def keys
    %i(source source_id attribution_url attribution_text attribution_html)
  end
end

RSpec::Matchers.define :have_photos do
  match do |recipe_hash|
    photos = get_photos(recipe_hash)
    get_photos(recipe_hash).present? &&
      get_photos(recipe_hash).all?{|photo| get_photo_versions(photo).count == 3 }

  end

  failure_message_for_should do |recipe_hash|
    if get_photos(recipe_hash).empty?
      "No photos included"
    else
      "Photos did not include all of #{%i(type url)}. Photos: #{get_photos(recipe_hash)}"
    end
  end

  def get_photos(recipe_hash)
    recipe_hash.fetch(:photos_attributes, [])
  end

  def get_photo_versions(photo_versions_hash)
    photo_versions_hash.fetch(:photo_versions_attributes, [])
  end
end

RSpec::Matchers.define :have_drink_photos do
  match do |drink|
    return false if drink.photos.blank?
    drink.photos.all? do |photo|
      photo.photo_versions.all? do |photo_version|
        photo_version.url.present? && photo_version.height.present? && photo_version.width.present?
      end
    end
  end
end

RSpec::Matchers.define :have_drink_ingredients do
  match do |drink|
    return false if drink.ingredients.blank?
    drink.ingredients.all? do |ingredient|
      ingredient.units.present? && ingredient.quantity.present? && ingredient.name.present?
    end
  end
end
