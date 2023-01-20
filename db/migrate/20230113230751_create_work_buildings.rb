class CreateWorkBuildings < ActiveRecord::Migration[7.0]
  def change
    create_table :work_buildings do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
