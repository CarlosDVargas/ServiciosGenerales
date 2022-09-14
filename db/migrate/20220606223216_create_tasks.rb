class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :assigned_at
      t.string :status, null: false, default: 'pending'
      t.belongs_to :employee, foreign_key: true, index: true, null: false
      t.belongs_to :request, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
