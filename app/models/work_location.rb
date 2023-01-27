class WorkLocation < ApplicationRecord
  belongs_to :work_building
  has_many :request_locations
end
