# frozen_string_literal: true
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
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  picture                           :string
#

class City < ApplicationRecord
  scope :on_map, lambda {
    where(_exists(
            Competition.finished.joins(:tracks)
                       .where("competitions.start_city_id = cities.id OR "\
                              "competitions.end_city_id = cities.id OR "\
                              "tracks.start_city_id = cities.id OR "\
                              "tracks.end_city_id = cities.id")
    ))
  }

  has_many :start_of_competitions, class_name: "Competition", foreign_key: "start_city_id"
  has_many :end_of_competitions, class_name: "Competition", foreign_key: "end_city_id"

  has_many :start_of_tracks, class_name: "Track", foreign_key: "start_city_id"
  has_many :end_of_tracks, class_name: "Track", foreign_key: "end_city_id"

  has_many :start_of_track_competitions, through: :start_of_tracks, source: :competition
  has_many :end_of_track_competitions, through: :end_of_tracks, source: :competition

  geocoded_by :name, latitude: :lat, longitude: :lng
  after_validation :geocode, if: :name_changed?

  def competition
    start_of_competitions.first
  end
end
