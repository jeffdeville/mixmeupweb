class Drink < ActiveRecord::Base
  has_many :ingredients
  has_many :photos
end
