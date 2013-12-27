class Ingredient < ActiveRecord::Base
  belongs_to :drink
  belongs_to :alcohol

  def assign_alcohol
    matched_alcohol = Alcohol.match_ingredient name
    self.alcohol = matched_alcohol
  end
end
