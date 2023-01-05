class Campus < ApplicationRecord
  has_many :employees
  has_many :requests
end
