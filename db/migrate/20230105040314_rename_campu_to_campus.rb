class RenameCampuToCampus < ActiveRecord::Migration[7.0]
  def change
    rename_table :campus, :campus
  end
end
