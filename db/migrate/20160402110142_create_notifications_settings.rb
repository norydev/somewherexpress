class CreateNotificationsSettings < ActiveRecord::Migration
  def change
    create_table :notification_settings do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :as_user_new_competition, default: true, null: false
      t.boolean :as_user_competition_edited, default: true, null: false
      t.boolean :as_user_new_subscription, default: true, null: false
      t.boolean :as_user_subscription_satus_changed, default: true, null: false
      t.boolean :as_author_new_subscription, default: true, null: false
      t.boolean :as_author_cancelation, default: true, null: false

      t.timestamps null: false
    end

    User.all.each do |u|
      NotificationSetting.create!(user: u)
    end
  end
end
