require 'spec_helper'

describe YummlyService::Cacher do
  include Mongo

  let(:client) { Mongo::MongoClient.from_uri(Rails.application.secrets.mongo_uri).db }
  before { client.collection(YummlyService::Cacher::COLLECTION).remove }

  describe ".upsert" do
    context "when new" do
      let(:recipe_hash) { build(:yummly_recipe).json }

      before { subject.upsert(recipe_hash) }

      let(:upserted_recipe){ subject.get(recipe_hash["id"]) }

      it "should have upserted" do
        expect(upserted_recipe.symbolize_keys).to include(recipe_hash)
      end
    end
  end

  describe ".recipes" do
    # I want to make sure that I am loading everything
    before do
      subject.upsert({"id" => 234, "value" => 1} )
      subject.upsert({"id" => 345, "value" => 2} )
    end

    let(:recipes) { subject.recipes }

    it "should have loaded both recipes" do
      expect(recipes.count).to eq 2
    end
  end
end
