class RemoveDataFromUsers < ActiveRecord::Migration[5.0]
  def change
    # this was meant to automate draws, which will never happen, irrelevant now
    remove_column :users, :girl, :boolean, default: false, null: false

    # Don't need to know that
    remove_column :users, :current_sign_in_ip, :inet
    remove_column :users, :last_sign_in_ip, :inet
    remove_column :users, :sign_in_count, :integer, default: 0, null: false
    remove_column :users, :current_sign_in_at, :datetime
    remove_column :users, :last_sign_in_at, :datetime
  end
end
