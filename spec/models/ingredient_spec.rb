require 'spec_helper'
require File.join(Rails.root, "db", "alcohols.rb")
require "phys/units"

describe Ingredient do
  describe '#assign_alcohol' do
    before(:all) { load_alcohols }

    context "when ingredient don't have an alcohol" do
      subject { create :blueberries_ingredient }
      before { subject.assign_alcohol }
      specify { subject.alcohol.should be_nil }
    end

    context "when ingredient has an alcohol in the name" do
      subject { create :vodka_ingredient }
      before { subject.assign_alcohol }
      it { subject.alcohol.name.should == "Vodka"}
    end
  end

  describe "#abv" do
    context "with an alcohol" do
      subject { create(:vodka_ingredient, :with_alcohol).abv }
      it "should be calculated correctly" do
        should == 0.2
      end
    end
    context "without an alcohol" do
      subject { create(:blueberries_ingredient).abv }
      specify { should == 0 }
    end
  end

  describe "#alcohol_in_floz" do
    Q = Phys::Quantity
    U = Phys::Unit

    context "with an alcohol" do
      subject { FactoryGirl.create :vodka_ingredient, :with_alcohol, :as_tbsp, quantity: 4 }
      specify { subject.alcohol_in_floz.should eq_with_units Q[0.4, 'floz'] }
    end

    context "with an alcohol missing quantity" do
      subject { FactoryGirl.create :vodka_ingredient, :with_alcohol, :as_tbsp, quantity: nil }
      specify { expect{subject.alcohol_in_floz}.to raise_error "Drink has an alcohol without a quantity, so proof can't be calculated" }
    end

    context "with an alcohol missing unit" do
      subject { FactoryGirl.create :vodka_ingredient, :with_alcohol, :as_tbsp, units: nil }
      specify { expect{subject.alcohol_in_floz}.to raise_error "Drink has an alcohol without units, so proof can't be calculated" }
    end
  end
end
