class MoveAttributesFromSubscriptionToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
    add_column :users, :whatsapp, :boolean, default: false, null: false
    add_column :users, :telegram, :boolean, default: false, null: false
    add_column :users, :signal, :boolean, default: false, null: false

    User.includes(:subscriptions).find_each do |u|
      last_sub = u.subscriptions.order(created_at: :desc).first
      next unless last_sub
      u.phone_number = last_sub.phone_number
      u.whatsapp = last_sub.whatsapp
      u.telegram = last_sub.telegram
      u.signal = last_sub.signal
      u.save!
    end
  end
end
