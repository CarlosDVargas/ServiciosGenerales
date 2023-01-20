class WorkLocation < ApplicationRecord
  belongs_to :work_building
  has_many :requests
end
