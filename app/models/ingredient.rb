class Ingredient < ActiveRecord::Base
  belongs_to :drink
  belongs_to :alcohol
end
