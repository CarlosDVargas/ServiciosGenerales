class AddCampusForeignKeys < ActiveRecord::Migration[7.0]
  def change
    change_table :requests do |t|
      t.references :campus, foreign_key: true
    end
    change_table :user_accounts do |t|
      t.references :campus, foreign_key: true
    end
  end
end
