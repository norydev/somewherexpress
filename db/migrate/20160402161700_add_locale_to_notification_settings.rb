class AddLocaleToNotificationSettings < ActiveRecord::Migration
  def change
    add_column :notification_settings, :locale, :string, null: false, default: :fr
  end
end
