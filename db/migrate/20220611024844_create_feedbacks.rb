class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.text :observations, limit: 500
      t.integer :satisfaction, range: 1..5
      t.belongs_to :request, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
