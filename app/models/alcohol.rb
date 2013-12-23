class Alcohol < ActiveRecord::Base
  scope :primary, -> { where(is_primary: true) }
end
