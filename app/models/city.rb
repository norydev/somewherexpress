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

class City < ActiveRecord::Base
  belongs_to :localizable, polymorphic: true

  geocoded_by :name, latitude: :lat, longitude: :lng
  after_validation :geocode, if: :name_changed?

  def competition
    if localizable_type == "Competition"
      localizable
    else
      localizable.competition
    end
  end

  def self.on_map
    select { |c| c.competition.finished? }
  end
end
