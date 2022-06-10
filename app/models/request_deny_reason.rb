class RequestDenyReason < ApplicationRecord
  belongs_to :request
  belongs_to :user_account # who denied the request

  attr_accessor :user_id, :request_id
end
