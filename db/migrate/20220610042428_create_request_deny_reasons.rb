class CreateRequestDenyReasons < ActiveRecord::Migration[7.0]
  def change
    create_table :request_deny_reasons do |t|
      t.string :reason, null: false
      t.integer :user_account_id, null: false
      t.integer :request_id, null: false

      t.timestamps
    end

    add_foreign_key :request_deny_reasons, :user_accounts
    add_foreign_key :request_deny_reasons, :requests
  end
end
