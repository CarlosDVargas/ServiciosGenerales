class WorkBuilding < ApplicationRecord
  has_many :work_locations, -> { order(name: :asc) }
  has_many :request_locations
  belongs_to :campus
end
