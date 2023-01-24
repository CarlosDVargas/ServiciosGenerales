class WorkBuilding < ApplicationRecord
  has_many :work_locations, -> { order(name: :asc) }
  belongs_to :campus
end
