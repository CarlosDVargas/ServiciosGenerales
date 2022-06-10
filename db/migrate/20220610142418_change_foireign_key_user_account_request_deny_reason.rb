class ChangeFoireignKeyUserAccountRequestDenyReason < ActiveRecord::Migration[7.0]
  def change
    rename_column :request_deny_reasons, :user_id, :user_account_id
  end
end
