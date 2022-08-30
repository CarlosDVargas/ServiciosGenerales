class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :requester_name, null: false
      t.string :requester_extension, null: false
      t.string :requester_phone, null: false
      t.string :requester_id, null: false
      t.string :requester_mail, null: false
      t.string :requester_type, null: false
      t.string :student_id
      t.string :student_association
      t.string :work_location, null: false
      t.string :work_building, null: false
      t.string :work_type, null: false
      t.text :work_description, null: false
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end
  end
end
