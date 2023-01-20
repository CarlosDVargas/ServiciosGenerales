class WorkBuilding < ApplicationRecord
  has_many :work_locations
  belongs_to :campus
end
