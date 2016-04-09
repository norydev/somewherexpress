class ChangeColumnNameInNotifications < ActiveRecord::Migration
  def change
    rename_column :notification_settings, :as_user_subscription_satus_changed, :as_user_subscription_status_changed
  end
end
