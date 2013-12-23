module YummlyService
  class Cacher
    include Mongo
    COLLECTION='yummly_drinks'
    attr_reader :client
    def initialize
      @client = MongoClient.from_uri(Rails.application.secrets.mongo_uri).db
    end

    def upsert(recipe_hash)
      @client.collection(COLLECTION).insert(recipe_hash.merge({_id: recipe_hash["id"]}))
    end

    def get(id)
      @client.collection(COLLECTION).find_one({_id: id})
    end

    def exists?(id)
      !get(id).nil?
    end

    def recipes
     @client.collection(COLLECTION).find()
    end
  end
end
