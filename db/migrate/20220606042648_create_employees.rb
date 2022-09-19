class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :employee_id_card, null: false, unique: true
      t.integer :employee_status, null: false
      t.integer :employee_type, null: false, default: 0
      t.timestamps
    end

    change_table :user_accounts do |t|
      t.belongs_to :employee, foreign_key: true, index: true, null: false
    end

  end
end
