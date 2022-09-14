class CreateLogEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :log_entries do |t|
      t.belongs_to :user_account, foreign_key: true, index: true, null: false
      t.belongs_to :request, foreign_key: true, index: true, null: false
      t.string :entry_message, null: false

      t.timestamps
    end
  end
end
