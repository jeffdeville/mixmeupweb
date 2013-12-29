class Ingredient < ActiveRecord::Base
  belongs_to :drink
  belongs_to :alcohol

  def assign_alcohol
    matched_alcohol = Alcohol.match_ingredient name
    self.alcohol = matched_alcohol
  end

  def abv
    alcohol.nil? ? 0 : alcohol.proof / 2.0 / 100
  end

  def alcohol_in_floz
    if alcohol.nil?
      return Q[0,'floz']
    elsif quantity.blank?
      raise ArgumentError, "Drink has an alcohol without a quantity, so proof can't be calculated"
    elsif units.blank?
      raise ArgumentError, "Drink has an alcohol without units, so proof can't be calculated"
    end

    (Q[quantity.to_f, units.downcase] * abv).want('floz')
  end
end
