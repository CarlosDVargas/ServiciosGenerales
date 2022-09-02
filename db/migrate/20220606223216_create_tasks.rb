class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :employee_id, null: false
      t.integer :request_id, null: false
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :assigned_at
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end
  end
end
