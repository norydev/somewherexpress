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

class Track < ApplicationRecord
  belongs_to :competition
  has_many :ranks, as: :race, dependent: :destroy

  belongs_to :start_city, class_name: "City", foreign_key: "start_city_id"
  belongs_to :end_city, class_name: "City", foreign_key: "end_city_id"

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
