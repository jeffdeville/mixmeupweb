require 'spec_helper'
require File.join(Rails.root, "db", "alcohols.rb")

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
end
