class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.text :observations, limit: 500
      t.integer :satisfaction, range: 1..5
      t.integer :request_id, null: false

      t.timestamps
    end

    add_foreign_key :feedbacks, :requests, column: :request_id
  end
end
