class CreateReopenReasons < ActiveRecord::Migration[7.0]
  def change
    create_table :reopen_reasons do |t|
      t.string :reason, null: false
      t.belongs_to :user_account, null: false, foreign_key: true
      t.belongs_to :request, null: false, foreign_key: true
      t.timestamps
    end
  end
end
