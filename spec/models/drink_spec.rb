require 'spec_helper'

describe Drink do
  describe ".create" do
    let(:drink_hash) {
      {
        photos_attributes: [
          photo_versions_attributes: [
            {url: "large_url", height: 1000, width: 1000 },
            {url: "medium_url", height: 500, width: 500 },
          ]
        ],
        ingredients_attributes: [
          { units: "cup", quantity: 1.5, name: "chopped pecans" },
          { units: "fl oz", quantity: 1, name: "rum" },
        ]
      }
    }

    let!(:drink) { Drink.create(drink_hash) }

    it "should have built the drink correctly" do
      expect(drink).to have_drink_photos
      expect(drink).to have_drink_ingredients
    end
  end

  # describe ".calculate_proof" do
  #   before { create :vodka }
  #   subject { create :blueberry_lemon_fizz } # 4oz of vodka, at 60 proof
  #   specify {expect(drink.total_alcohol).to eq 200 }
  # end
end

