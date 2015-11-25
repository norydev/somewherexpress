FactoryGirl.define do
  factory :subscription do
    association   :user
    association   :competition
    status        "accepted"
  end
end
