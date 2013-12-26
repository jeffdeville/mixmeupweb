module FatSecretService
  class Cacher
    include Mongo
    COLLECTION="fatsecret_alcohols"
    attr_reader :client
    def initialize
      @client = MongoClient.from_uri(Rails.application.secrets.mongo_uri).db
    end

    def upsert(alcohol_hash)
      @client.collection(COLLECTION).insert(alcohol_hash.merge({_id: alcohol_hash["food_url"]}))
    end

    def alcohols
      @client.collection(COLLECTION).find().to_a
    end
  end
end
