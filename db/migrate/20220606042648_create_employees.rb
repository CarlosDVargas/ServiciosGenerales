class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :employee_id_card, null: false
      t.integer :employee_status, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_foreign_key :employees, :user_accounts, column: :user_id
  end
end
