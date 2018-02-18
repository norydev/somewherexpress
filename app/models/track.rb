# frozen_string_literal: true
# == Schema Information
#
# Table name: tracks
#
#  id             :integer          not null, primary key
#  competition_id :integer
#  start_time     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  start_city_id  :integer
#  end_city_id    :integer
#
# Indexes
#
#  index_tracks_on_competition_id                 (competition_id)
#  index_tracks_on_start_city_id_and_end_city_id  (start_city_id,end_city_id)
#
# Foreign Keys
#
#  fk_rails_...  (competition_id => competitions.id)
#  fk_rails_...  (end_city_id => cities.id)
#  fk_rails_...  (start_city_id => cities.id)
#

class Track < ApplicationRecord
  belongs_to :competition
  has_many :ranks, as: :race, dependent: :destroy, inverse_of: :race

  belongs_to :start_city, class_name: "City", foreign_key: "start_city_id",
                          inverse_of: :start_of_tracks
  belongs_to :end_city, class_name: "City", foreign_key: "end_city_id",
                        inverse_of: :end_of_tracks

  after_create :make_track_ranks

  def name
    "#{start_city.locality} (#{start_city.country_short}) – #{end_city.locality} (#{end_city.country_short})"
  end

  def to_s
    name
  end

  private

    def make_track_ranks
      competition.accepted_users.each do |user|
        Rank.create!(user: user, race: self)
      end
    end
end
