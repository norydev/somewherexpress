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

  def self.on_map
    fc1 = joins(:start_of_competitions)
          .where(competitions: { finished: true })
          .ids

    fc2 = joins(:end_of_competitions)
          .where(competitions: { finished: true })
          .ids

    fc3 = joins(:start_of_track_competitions)
          .where(competitions: { finished: true })
          .ids

    fc4 = joins(:end_of_track_competitions)
          .where(competitions: { finished: true })
          .ids

    where.(id: fc1 | fc2 | fc3 | fc4)
  end

  def self.nowhere
    c1 = joins(:start_of_competitions).ids
    c2 = joins(:end_of_competitions).ids
    c3 = joins(:start_of_tracks).ids
    c4 = joins(:end_of_tracks).ids

    City.where.not(id: c1 | c2 | c3 | c4)
  end
end
