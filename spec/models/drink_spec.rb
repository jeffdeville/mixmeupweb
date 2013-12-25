require 'spec_helper'

describe Drink do
  RSpec::Matchers.define :have_drink_photos do
      match do |drink|
        return false if drink.photos.blank?
        drink.photos.all? do |photo|
          photo.photo_versions.all? do |photo_version|
            photo_version.url.present? && photo_version.height.present? && photo_version.width.present?
          end
        end
      end
  end
  describe ".create" do
    let(:drink_hash) {
      {
        photos_attributes: [
          photo_versions_attributes: [
            {url: "large_url", height: 1000, width: 1000 },
            {url: "medium_url", height: 500, width: 500 },
          ]
        ]
      }
    }

    let!(:drink) { Drink.create(drink_hash) }

    it "should have built the drink correctly" do
      expect(drink).to have_drink_photos
    end

  end

  describe ".calculate_proof" do
    before
      create :vodka
    end
    subject { create :blueberry_lemon_fizz } # 4oz of vodka, at 60 proof
    specify {expect(drink.total_alcohol).to eq 200 }
  end
end
