class CreateLogEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :log_entries do |t|
      t.integer :user_account_id
      t.string :entry_message
      t.integer :request_id

      t.timestamps
    end
  end
end
