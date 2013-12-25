module FatSecretService
  module Tasks
    extend self

    def cache
      db.upsert(FatSecretService::Extracter.get_alcohols)
    end

    def load
      db.alcohols.each do |alcohol_hash|
        attributes = FatSecretService::Translator.map(alcohol_hash)
        Alcohol.create attributes
      end
    end

    private
    def db
      @db ||= FatSecretService::Cacher.new
    end

  end
end
