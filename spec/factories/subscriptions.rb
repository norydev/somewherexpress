FactoryGirl.define do
  factory :subscription do
    association   :user
    association   :competition
  end
end
