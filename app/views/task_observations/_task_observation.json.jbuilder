json.extract! task_observation, :id, :description, :user_id, :task_id, :created_at, :updated_at
json.url task_observation_url(task_observation, format: :json)
