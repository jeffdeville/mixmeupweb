require "phys/units"

class Drink < ActiveRecord::Base
  has_many :ingredients
  has_many :photos
  accepts_nested_attributes_for :photos, :ingredients

  Q = Phys::Quantity
  def calculate_proof
    total_alcohol / total_alcohol
  end

  def total_alcohol
    ingredients.map(&:alcohol_in_floz).reduce(Q[0.0,'floz'], :+)
  end

  def total_volume
    0
  end
end
