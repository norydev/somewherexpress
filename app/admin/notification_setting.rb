# frozen_string_literal: true
ActiveAdmin.register NotificationSetting do
  permit_params :user_id, :locale, :as_user_new_competition,
                :as_user_competition_edited, :as_user_new_subscription,
                :as_user_subscription_status_changed, :as_author_new_subscription,
                :as_author_cancelation

  index do
    selectable_column
    column :user
    column :locale
    column :as_user_new_competition
    column :as_user_competition_edited
    column :as_user_new_subscription
    column :as_user_subscription_status_changed
    column :as_author_new_subscription
    column :as_author_cancelation
    actions
  end

  form do |f|
    f.inputs "Notifications" do
      f.input :user
      f.input :locale, collection: [["English", "en"], ["French", "fr"]]
      f.input :as_user_new_competition
      f.input :as_user_competition_edited
      f.input :as_user_new_subscription
      f.input :as_user_subscription_status_changed
      f.input :as_author_new_subscription
      f.input :as_author_cancelation
    end

    f.actions
  end
end
