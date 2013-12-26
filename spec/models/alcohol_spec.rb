require 'spec_helper'
require File.join(Rails.root, "db", "alcohols")
describe Alcohol do
  describe ".cached_alcohols" do
    let!(:alcohols) { [create(:vodka)] }
    let(:cached_alcohols) { Alcohol.all_alcohols }

    it "should cache the alcohols" do
      expect(alcohols.count).to eq cached_alcohols.count
    end

    context "when a new alcohol is added" do
      it "should update the cache" do
        expect(Alcohol.all_alcohols).to have(1).alcohol
        weird = Alcohol.create(attributes_for :weird_alcohol)
        expect(Alcohol.all_alcohols).to have(2).alcohols
      end
    end
  end

  # describe ".match_ingredient" do
  #   before do
  #     load_alcohols
  #   end
  #   it "should map alcohols" do
  #     Alcohol.match_ingredient("vodka")
  #   end
  # end
end
