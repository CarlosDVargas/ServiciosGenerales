json.extract! task, :id, :employee_id, :request_id, :started_at, :finished_at, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
