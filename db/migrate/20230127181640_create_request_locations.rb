class CreateRequestLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :request_locations do |t|
      t.string :name
      t.references :work_location, null: true, foreign_key: true
      t.references :request, null: false, foreign_key: true
      t.timestamps
    end

    change_table :requests do |t|
      t.remove :work_location_id
    end
  end
end
