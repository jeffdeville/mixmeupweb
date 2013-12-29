require 'spec_helper'
require "phys/units"

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

  context "when calculating the alcohol content" do
    Q = Phys::Quantity
    U = Phys::Unit

    describe "#total_alcohol" do
      context "with just a single alcohol in floz" do
        subject { create :blueberry_lemon_fizz }
        specify { subject.total_alcohol.should eq_with_units Q[0.8, 'floz'] }
      end

      context "with multiple alcohols in different dimensions" do
        subject { create :bavarian_wild_berry_cosmo }
        specify { subject.total_alcohol.should eq_with_units Q[0.275, "floz"] }
      end

      context "with an alcohol missing quantity" do
        subject { create :drink_with_alcohol_without_quantity }
        specify { expect{subject.total_alcohol}.to raise_error "Drink has an alcohol without a quantity, so proof can't be calculated" }
      end

      context "with an alcohol missing unit" do
        subject { create :drink_with_alcohol_without_unit }
        specify { expect{subject.total_alcohol}.to raise_error "Drink has an alcohol without units, so proof can't be calculated" }
      end
    end

    describe "#total_volume" do
      # specify { expect(subject.total_alcohol).to eq 100 }
    end

    # describe "#calculate_proof" do
    #   specify { expect(subject.calculate_proof).to eq(30) }
    # end
  end
end

