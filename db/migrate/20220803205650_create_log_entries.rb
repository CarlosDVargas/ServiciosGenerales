class CreateLogEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :log_entries do |t|
      t.integer :user_account_id, null: false
      t.string :entry_message, null: false
      t.integer :request_id, null: false

      t.timestamps
    end

    add_foreign_key :log_entries, :user_accounts
    add_foreign_key :log_entries, :requests
  end
end
