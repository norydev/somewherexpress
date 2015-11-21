class AddValidationsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :status, :string, null: false, default: "applied"
  end
end
