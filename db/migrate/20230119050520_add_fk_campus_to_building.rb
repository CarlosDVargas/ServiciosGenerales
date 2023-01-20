class AddFkCampusToBuilding < ActiveRecord::Migration[7.0]
  def change
    change_table :work_buildings do |t|
      t.references :campus, foreign_key: true
    end
  end
end
