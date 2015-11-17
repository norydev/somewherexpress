FactoryGirl.define do
  factory :track do
    association     :competition
    start_time      DateTime.parse("10 april 2015 14:00")
    start_location  "Yverdon-les-Bains, Suisse"
    end_location    "Paris, France"
    start_location_street_number ""
    start_location_route ""
    start_location_locality "Yverdon-les-Bains"
    start_location_administrative_area_level_2 "Jura-Nord vaudois"
    start_location_administrative_area_level_1 "Vaud"
    start_location_administrative_area_level_1_short "VD"
    start_location_country "Suisse"
    start_location_country_short "CH"
    start_location_postal_code ""
    end_location_street_number ""
    end_location_route ""
    end_location_locality "Paris"
    end_location_administrative_area_level_2 "Paris"
    end_location_administrative_area_level_1 "Île-de-France"
    end_location_administrative_area_level_1_short "IDF"
    end_location_country "France"
    end_location_country_short "FR"
    end_location_postal_code ""
  end

end
