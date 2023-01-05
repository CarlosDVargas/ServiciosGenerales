class CreateCampus < ActiveRecord::Migration[7.0]
  def change
    create_table :campus do |t|
      t.string :campus_id, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
