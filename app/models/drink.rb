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
    ingredients.reduce(Q[0,'floz']) do |sum, ingredient|
      if ingredient.alcohol.nil?
        sum
      elsif ingredient.quantity.blank?
        raise ArgumentError, "Drink has an alcohol without a quantity, so proof can't be calculated"
      elsif ingredient.units.blank?
        raise ArgumentError, "Drink has an alcohol without units, so proof can't be calculated"
      else
        abv = (ingredient.alcohol.proof / 2.0) / 100
        sum + (Q[ingredient.quantity.to_f, ingredient.units.downcase] * abv)
      end
    end
  end

  def total_volume
    0
  end
end
