class AddFkLocationToRequest < ActiveRecord::Migration[7.0]
  def change
    remove_column :requests, :work_location
    remove_column :requests, :work_building
    change_table :requests do |t|
      t.references :work_location, foreign_key: true
    end
  end
end
