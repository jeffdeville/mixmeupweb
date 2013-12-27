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

  describe ".matches?" do
    it "should match on the name" do
      vodka = build :vodka
      expect(vodka.matches? "Vodka").to be_true
      expect(vodka.matches? "vodka").to be_true
      expect(vodka.matches? "blueberry vodka beans").to be_true
      expect(vodka.matches? "gin").to be_false
    end

    it "should match on the keywords" do
      brandy = build :brandy, search_terms: ["brandy", "cognac"]
      expect(brandy.matches? "brandy").to be_true
      expect(brandy.matches? "cognac").to be_true
    end
  end

  describe ".match_ingredient" do
    before { load_alcohols }

    it "should map the alcohols in the ingredient lines list" do
      matches, not_matches = *File.open(File.join(Rails.root, "spec", "models", "ingredient_lines.txt")).take(1000).partition do |ingredient_line|
        Alcohol.match_ingredient(ingredient_line)
      end

      File.open("matches.txt", 'w') { |file| matches.uniq.sort.each{|match| file.write(match) } }
      File.open("not_matches.txt", 'w') { |file| not_matches.uniq.sort.each{|not_match| file.write(not_match) } }
    end
  end
end
