require 'spec_helper'

describe FatSecretService::Tasks do
  let(:client) { Mongo::MongoClient.from_uri(Rails.application.secrets.mongo_uri).db }
  before { client.collection(FatSecretService::Cacher::COLLECTION).remove }
  let(:loaded_alcohols) { FatSecretService::Cacher.new.alcohols }

  def cache_alcohols
    VCR.use_cassette("fatsecret", match_requests_on: [:fatsecret]) do
      subject.cache
    end
  end

  describe ".cache" do

    before { cache_alcohols }

    it "should cache the alcohols from fatsecret" do
      loaded_alcohols.should_not be_empty
      expect(loaded_alcohols.first).to have_third_party_id(:food_url)
    end
  end

  # Ignoring this, because it looks like fatsecret is not that useful
  # describe ".load" do
  #   before { cache_alcohols }

  #   before { subject.load }

  #   it "should have mapped and created the alcohols in postgres" do
  #     expect(Alcohol.count).to eq loaded_alcohols.count
  #     Alcohol.all.each do |alcohol|
  #       expect(alcohol).to have_proof
  #     end
  #   end

  # end
end
