require 'spec_helper'
require File.join(Rails.root, "db", "alcohols.rb")

describe Ingredient do
  describe '.assign_alcohol' do
    before(:all) { load_alcohols }

    context "should leave ingredients alone that don't have an alcohol in them" do
      subject { create :blueberries_ingredient }
      before { subject.assign_alcohol }
      specify { subject.alcohol.should be_nil }
    end

    context "should assign an alcohol if one exists" do
      subject { create :vodka_ingredient }
      before { subject.assign_alcohol }
      specify { subject.alcohol.should_not be_nil }
    end
  end
end
