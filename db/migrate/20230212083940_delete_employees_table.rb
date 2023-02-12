class DeleteEmployeesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :employees
  end
end
