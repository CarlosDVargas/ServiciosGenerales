class AddForeignKeyToUserAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :user_accounts, :employee_id, :int
    add_foreign_key :user_accounts, :employees, column: :employee_id, on_delete: :cascade
  end
end
