class CreateTaskObservations < ActiveRecord::Migration[7.0]
  def change
    create_table :task_observations do |t|
      t.text :description, null: false
      t.belongs_to :task, foreign_key: true, index: true, null: false
      t.belongs_to :user_account, foreign_key: true, index: true, null: false
      t.timestamps
    end
  end
end
