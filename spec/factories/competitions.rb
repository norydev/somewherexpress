FactoryGirl.define do
  factory :competition do
    name            "Paris express 15"
    start_date      Date.parse("10 april 2015")
    end_date        Date.parse("15 april 2015")
    start_location  "Yverdon-les-Bains"
    end_location    "Paris"
    start_location_street_number   ""
    start_location_route   ""
    start_location_locality    "Yverdon-les-Bains"
    start_location_administrative_area_level_2   "Jura-Nord vaudois"
    start_location_administrative_area_level_1   "Vaud"
    start_location_administrative_area_level_1_short   "VD"
    start_location_country   "Suisse"
    start_location_country_short   "CH"
    start_location_postal_code   ""
    end_location_street_number   ""
    end_location_route   ""
    end_location_locality    "Paris"
    end_location_administrative_area_level_2   "Paris"
    end_location_administrative_area_level_1   "Île-de-France"
    end_location_administrative_area_level_1_short   "IDF"
    end_location_country   "France"
    end_location_country_short   "FR"
    end_location_postal_code   ""
    finished  true
    published false
    start_registration    DateTime.parse("10 november 2014")
    end_registration      DateTime.parse("1 april 2015")
    association           :author, factory: :user, email: "ramirez@yopmail.com"
    description           "This race is great"
  end

end