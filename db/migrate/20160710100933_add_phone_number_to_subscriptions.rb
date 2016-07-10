class AddPhoneNumberToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :phone_number, :string
    add_column :subscriptions, :whatsapp, :boolean, default: false, null: false
    add_column :subscriptions, :telegram, :boolean, default: false, null: false
    add_column :subscriptions, :signal, :boolean, default: false, null: false
  end
end
