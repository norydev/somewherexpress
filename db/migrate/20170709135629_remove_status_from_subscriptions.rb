class RemoveStatusFromSubscriptions < ActiveRecord::Migration[5.0]
  def change
    remove_column :subscriptions, :status, :string, default: "pending", null: false
  end
end
