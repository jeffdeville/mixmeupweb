require 'spec_helper'

describe FatSecretService::Extracter do
  describe ".get_alcohols" do
    let(:alcohols) do
      VCR.use_cassette("fat_secret", record: :none, match_requests_on: [:fatsecret]) do

        subject.get_alcohols
      end
    end

    it "should have loaded the alcohols" do
      expect(alcohols.count).to be > 10
    end
  end
end
