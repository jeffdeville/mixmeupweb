class Alcohol < ActiveRecord::Base
  scope :primary, -> { where(is_primary: true) }

  def self.primary_alcohols
    Alcohol.primary.pluck(:name).map(&:downcase)
  end

  def has_proof?
    proof.present?
  end
end
