module YummlyService
  module Extracter
    extend self

    def find_drinks_with(alcohol: alcohol)
      [].tap do |results|
        SearchParameterEnumerator.courses.each do |course|
          SearchParameterEnumerator.new(alcohol, course).each do |params|
            recipes = get_complete_recipes(params)
            break if recipes.blank?
            results += recipes
          end
        end
        return results.flatten
      end
    end

    def get(id)
      Yummly.find(id)
    end

    private

    def get_complete_recipes(params)
      Yummly.search(nil, params).matches.
        select{|recipe| !recipe["id"].blank? }.
        select{|recipe| !recipe["imageUrlsBySize"].blank? }
    end


  end
end
