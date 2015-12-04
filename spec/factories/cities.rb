FactoryGirl.define do
  factory :city do
    name          "Yverdon-les-Bains, Suisse"
    lat           46.7784736
    lng           6.641183
    street_number ""
    route         ""
    locality      "Yverdon-les-Bains"
    administrative_area_level_2 "Jura-Nord vaudois"
    administrative_area_level_1 "Vaud"
    administrative_area_level_1_short "VD"
    country         "Suisse"
    country_short   "CH"
    postal_code     ""
    association     :localizable
    order           "start"
  end
end