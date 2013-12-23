require 'spec_helper'

describe YummlyService::Tasks, slow: true do
  let(:db) { Mongo::MongoClient.from_uri(Rails.application.secrets.mongo_uri).db }
  before { db.collection(YummlyService::Cacher::COLLECTION).remove }

  describe  ".cache" do
    before { create :vodka }
    before do
      VCR.use_cassette("yummly") do
        YummlyService::Tasks.cache
      end
    end

    it "should search for all of the vodka drinks, and load them into mongo" do
      expect(db.collection("recipes").count).to be > 0
    end
  end
end
