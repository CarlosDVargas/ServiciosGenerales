class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :employee_id_card, null: false, unique: true
      t.integer :employee_status, null: false
      t.integer :employee_type, null: false, default: 0
      t.timestamps
    end

    add_foreign_key :user_accounts, :employees
    add_index :employees, :employee_id_card, unique: true
  end
end
