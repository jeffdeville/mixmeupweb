require 'spec_helper'

describe FatSecretService::Tasks do
  describe ".cache" do
    let(:loaded_alcohols) { FatSecretService::Cacher.new.alcohols }
    it "should cache the alcohols from fatsecret" do
      VCR.use_cassette("fatsecret") do
        subject.cache
      end

      loaded_alcohols.should_not be_empty
    end
  end
end
