class RequestLocation < ApplicationRecord
  belongs_to :request
  belongs_to :work_location, optional: true
  belongs_to :work_building
end
