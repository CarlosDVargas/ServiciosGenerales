class ChangeFoireignKeyUserAccountObservation < ActiveRecord::Migration[7.0]
  def change
    rename_column :task_observations, :user_id, :user_account_id
  end
end
