class RemoveForeignKeyEmployeeUsers < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :employees, :user_accounts, column: :user_id
    remove_column :employees, :user_id
  end
end
