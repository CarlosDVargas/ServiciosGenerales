class TaskObservation < ApplicationRecord
  belongs_to :task
  belongs_to :user_account
  has_one :request, through: :task
end
