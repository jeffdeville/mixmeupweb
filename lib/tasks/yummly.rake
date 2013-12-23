namespace :yummly do
  desc "load data from yummly into mongo for later processing"
  task :load => :environment do
    client = Mongo::MongoClient.from_uri Rails.application.secretes.mongo_uri
    alcohols = Alcohol.primary.to_a

    alcohols.map do |alcohol|
      Yummly.find_drinks_with(alcohol) do |recipe|
        upsert(recipe, client)
      end
    end
  end

  private
  def upsert(recipe, client)
    client.insert(recipe)
  end
end
