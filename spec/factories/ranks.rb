FactoryGirl.define do
  factory :rank do
    association   :user
    association   :race
    result        1
    points        5
  end
end
