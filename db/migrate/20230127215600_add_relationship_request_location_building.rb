class AddRelationshipRequestLocationBuilding < ActiveRecord::Migration[7.0]
  def change
    change_table :request_locations do |t|
      t.references :work_building, null: true, foreign_key: true
    end
  end
end
