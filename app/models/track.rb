# == Schema Information
#
# Table name: tracks
#
#  id             :integer          not null, primary key
#  competition_id :integer
#  start_time     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Track < ActiveRecord::Base
  belongs_to :competition
  has_many :ranks, as: :race, dependent: :destroy
  accepts_nested_attributes_for :ranks

  belongs_to :start_city, class_name: 'City', foreign_key: "start_city_id"
  belongs_to :end_city, class_name: 'City', foreign_key: "end_city_id"

  accepts_nested_attributes_for :start_city
  accepts_nested_attributes_for :end_city

  after_create :make_track_ranks

  validates_presence_of :start_city, :end_city, :start_time

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
