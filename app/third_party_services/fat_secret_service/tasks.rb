module FatSecretService
  module Tasks
    extend self

    def cache
      FatSecretService::Extracter.get_alcohols do |alcohol|
        alcohol["_id"] = alcohol["food_url"]
        db.upsert(alcohol)
      end
    end

    def load
      db.alcohols.each do |alcohol_hash|
        attributes = FatSecretService::Transformer.call(alcohol_hash)
        Alcohol.create attributes
      end
    end

    private
    def db
      @db ||= FatSecretService::Cacher.new
    end

  end
end
