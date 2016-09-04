class RemoveAttrFromSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :phone_number, :string
    remove_column :subscriptions, :whatsapp, :boolean, default: false, null: false
    remove_column :subscriptions, :telegram, :boolean, default: false, null: false
    remove_column :subscriptions, :signal, :boolean, default: false, null: false
  end
end
