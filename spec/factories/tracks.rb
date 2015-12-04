FactoryGirl.define do
  factory :track do
    association     :competition
    start_time      DateTime.parse("10 april 2015 14:00")
  end

end
