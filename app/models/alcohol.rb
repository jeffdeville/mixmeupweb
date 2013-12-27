class Alcohol < ActiveRecord::Base
  has_many :ingredients
  scope :primary, -> { where(is_primary: true) }
  after_save :clear_cache
  @@cache = nil

  def self.primary_alcohols
    Alcohol.primary.pluck(:name).map(&:downcase)
  end

  def self.all_alcohols
    @@cache ||= Alcohol.all.to_a
  end

  def self.match_ingredient(ingredient_text)
    all_alcohols.find do |alcohol|
      alcohol.matches?(ingredient_text)
    end
  end

  def has_proof?
    proof.present?
  end

  def matches?(text)
    search_terms.any? do |search_term|
      /#{search_term}/i =~ text
    end
  end

  private
  def clear_cache
    @@cache = nil
  end
end
