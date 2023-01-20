class Campus < ApplicationRecord
  has_many :employees
  has_many :requests
  has_many :work_buildings
end
