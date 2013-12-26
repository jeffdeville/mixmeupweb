require 'spec_helper'

describe YummlyService::Tasks, slow: true do
  let(:cache) { YummlyService::Cacher.new }
  describe  ".cache" do
    before { create :vodka }
    before { YummlyService::Tasks.cache }

    it "should search for all of the vodka drinks, and load them into mongo" do
      expect(cache.recipes).to have_at_least(10).recipes
    end
  end
end
