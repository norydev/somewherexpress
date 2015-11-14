class AddGirlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :girl, :boolean, default: false, null: false
  end
end
