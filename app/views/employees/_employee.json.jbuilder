json.extract! employee, :id, :employee_id_card, :employee_status, :user_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
