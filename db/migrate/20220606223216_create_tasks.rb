class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :employee_id, null: false
      t.integer :request_id, null: false
      t.datetime :started_at
      t.datetime :finished_at
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end

    add_foreign_key :tasks, :employees, column: :employee_id
    add_foreign_key :tasks, :requests, column: :request_id
  end
end
