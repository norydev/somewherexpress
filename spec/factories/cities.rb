# == Schema Information
#
# Table name: cities
#
#  id                                :integer          not null, primary key
#  name                              :string
#  street_number                     :string
#  route                             :string
#  locality                          :string
#  administrative_area_level_2       :string
#  administrative_area_level_1       :string
#  administrative_area_level_1_short :string
#  country                           :string
#  country_short                     :string
#  postal_code                       :string
#  lat                               :float
#  lng                               :float
#  localizable_id                    :integer
#  localizable_type                  :string
#  order                             :string           default("start"), not null
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#

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
  end
end
