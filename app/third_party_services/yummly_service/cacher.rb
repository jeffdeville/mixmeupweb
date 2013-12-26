module YummlyService
  class Cacher
    include Mongo
    COLLECTION='yummly_drinks'
    attr_reader :client
    def initialize
      @client = MongoClient.from_uri(Rails.application.secrets.mongo_uri).db
    end
    def recipes_collection
      @client.collection(COLLECTION)
    end
    def upsert(recipe_hash)
      recipes_collection.insert(recipe_hash.merge({_id: recipe_hash["id"]}))
    end

    def get(id)
      recipes_collection.find_one({_id: id})
    end

    def exists?(id)
      !get(id).nil?
    end

    def recipes
     recipes_collection.find()
    end

    def clear
      recipes_collection.remove
    end
  end
end
