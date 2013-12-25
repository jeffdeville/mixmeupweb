class Drink < ActiveRecord::Base
  has_many :ingredients
  has_many :photos
  accepts_nested_attributes_for :photos
end
