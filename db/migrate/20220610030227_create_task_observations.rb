class CreateTaskObservations < ActiveRecord::Migration[7.0]
  def change
    create_table :task_observations do |t|
      t.text :description, null: false
      t.integer :user_account_id, null: false
      t.integer :task_id, null: false

      t.timestamps
    end

    add_foreign_key :task_observations, :user_accounts
    add_foreign_key :task_observations, :tasks
  end
end
