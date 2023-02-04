class AddColumnToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :active, :boolean, default: true
  end
end
