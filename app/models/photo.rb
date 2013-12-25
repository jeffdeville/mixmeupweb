class Photo < ActiveRecord::Base
  belongs_to :drink
  has_many :photo_versions
  accepts_nested_attributes_for :photo_versions
end
