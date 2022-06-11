json.extract! feedback, :id, :observations, :satisfaction, :request_id, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)
