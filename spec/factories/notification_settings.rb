FactoryGirl.define do
  factory :notification_setting do
    as_user_new_competition true
    as_user_competition_edited true
    as_user_new_subscription true
    as_user_subscription_satus_changed true
    as_author_new_subscription true
    as_author_cancelation true
  end
end
