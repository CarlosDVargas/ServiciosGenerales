class AddIdentifierToRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :identifier, :string, null: false
  end
end
