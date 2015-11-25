class AddValidationsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :status, :string, null: false, default: "pending"
  end
end
