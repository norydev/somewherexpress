class AddEnumStatusOnSubscriptions < ActiveRecord::Migration[5.0]
  def up
    add_column :subscriptions, :enum_status, :integer, default: 0, null: false

    Subscription.where(status: "pending").update_all(enum_status: 0)
    Subscription.where(status: "accepted").update_all(enum_status: 1)
    Subscription.where(status: "refused").update_all(enum_status: 2)
  end

  def down
    Subscription.where(enum_status: 0).update_all(status: "pending")
    Subscription.where(enum_status: 1).update_all(status: "accepted")
    Subscription.where(enum_status: 2).update_all(status: "refused")

    remove_column :subscriptions, :enum_status, :integer, default: 0, null: false
  end
end
