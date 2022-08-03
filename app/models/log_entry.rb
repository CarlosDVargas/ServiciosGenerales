class LogEntry < ApplicationRecord
  belongs_to :user_account
  belongs_to :request
end
