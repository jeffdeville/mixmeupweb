class Alcohol < ActiveRecord::Base
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
    # Alcohol.all
  end

  def has_proof?
    proof.present?
  end

  private
  def clear_cache
    @@cache = nil
  end
end
