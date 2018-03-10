# frozen_string_literal: true
# == Schema Information
#
# Table name: cities
#
#  id            :integer          not null, primary key
#  name          :string
#  locality      :string
#  country_short :string
#  lat           :float
#  lng           :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  picture       :string
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

  has_many :start_of_competitions, class_name: "Competition",
                                   foreign_key: "start_city_id",
                                   dependent: :restrict_with_error,
                                   inverse_of: :start_city
  has_many :end_of_competitions, class_name: "Competition",
                                 foreign_key: "end_city_id",
                                 dependent: :restrict_with_error,
                                 inverse_of: :end_city

  has_many :start_of_tracks, class_name: "Track",
                             foreign_key: "start_city_id",
                             dependent: :restrict_with_error,
                             inverse_of: :start_city
  has_many :end_of_tracks, class_name: "Track",
                           foreign_key: "end_city_id",
                           dependent: :restrict_with_error,
                           inverse_of: :end_city

  has_many :start_of_track_competitions, through: :start_of_tracks, source: :competition
  has_many :end_of_track_competitions, through: :end_of_tracks, source: :competition

  geocoded_by :name, latitude: :lat, longitude: :lng
  after_validation :geocode, if: :name_changed?

  def competition
    start_of_competitions.first
  end
end
