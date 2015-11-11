class ChangeNullToSubscriptions < ActiveRecord::Migration
  def change
    change_column :subscriptions, :user_id, :integer, null: false
    change_column :subscriptions, :competition_id, :integer, null: false
  end
end
