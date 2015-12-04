FactoryGirl.define do
  factory :competition do
    name            "Paris express 15"
    start_date      Date.parse("10 april 2015")
    end_date        Date.parse("15 april 2015")
    finished        true
    published       false
    start_registration    DateTime.parse("10 november 2014")
    end_registration      DateTime.parse("1 april 2015")
    association           :author, factory: :user, email: "ramirez@yopmail.com"
    description           "This race is great"
    default_registration_status "accepted"
  end

end