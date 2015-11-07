FactoryGirl.define do
  factory :track do
    association     :competition
    start_time      DateTime.parse("18 april 2015 14:00")
    start_location  Faker::Address.city
    end_location    Faker::Address.city
  end

end
