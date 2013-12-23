require 'vcr'
module YummlyService
  module Tasks
    extend self

    # This should really only be saving me the calls that hit the search api.
    # Get queries are only requested if the cache is missing the data.
    VCR.configure do |c|
      c.cassette_library_dir = 'vcr_cassettes'
      c.hook_into :webmock
    end

    def cache
      Alcohol.primary.pluck(:name).map(&:downcase).each do |alcohol|
        recipes = VCR.use_cassette("yummly", record: :new_episodes) do
          YummlyService::Extracter.find_drinks_with(alcohol: alcohol)
        end

        VCR.use_cassette("yummly_get", record: :new_episodes) do
          recipes.each do |recipe|
            next if db.exists?(recipe["id"])
            begin
              db.upsert(YummlyService::Extracter.get(recipe["id"]).json)
            rescue
              raise $! unless $!.message =~ /Permission denied/
            end
          end
        end
      end
    end

    def load
      db.recipes.each do |recipe|
        attributes = YummlyService.Translator.map(recipe_hash)
        Drink.create(attributes)
      end
    end

    private
    def upsert(recipe, client)
      db.insert(recipe)
    end

    def db
      @db ||= YummlyService::Cacher.new
    end
  end
end
