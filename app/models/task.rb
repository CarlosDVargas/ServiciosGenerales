class Task < ApplicationRecord
  belongs_to :employee
  belongs_to :request

  has_many :task_observations, dependent: :destroy
  has_many :user_accounts, through: :task_observations
end
