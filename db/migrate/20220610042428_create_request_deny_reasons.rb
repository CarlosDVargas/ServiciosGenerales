class CreateRequestDenyReasons < ActiveRecord::Migration[7.0]
  def change
    create_table :request_deny_reasons do |t|
      t.string :reason, null: false
      t.belongs_to :request, foreign_key: true, index: true, null: false
      t.belongs_to :user_account, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
