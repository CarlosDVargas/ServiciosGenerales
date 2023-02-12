class Campus < ApplicationRecord
  has_many :user_accounts
  has_many :requests
  has_many :work_buildings
end
