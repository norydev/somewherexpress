class Track < ActiveRecord::Base
  belongs_to :competition
  has_many :ranks, as: :race, dependent: :destroy
  accepts_nested_attributes_for :ranks

  before_validation :geocoding, if: :location_changed?

  after_create :make_track_ranks

  validates_presence_of :competition, :start_location, :start_location_locality, :end_location, :end_location_locality, :start_time

  def to_s
    "#{start_location_locality} (#{start_location_country_short}) – #{end_location_locality} (#{end_location_country_short})"
  end

  private

    def geocoding
      if start_location.present?
        start_geo = Geocoder.search(start_location)
        self.start_location_lat = start_geo.first.data["geometry"]["location"]["lat"] if start_geo.first
        self.start_location_lng = start_geo.first.data["geometry"]["location"]["lng"] if start_geo.first
      end
      if end_location.present?
        end_geo = Geocoder.search(end_location)
        self.end_location_lat = end_geo.first.data["geometry"]["location"]["lat"] if end_geo.first
        self.end_location_lng = end_geo.first.data["geometry"]["location"]["lng"] if end_geo.first
      end
    end

    def location_changed?
      start_location_changed? || end_location_changed?
    end

    def make_track_ranks
      competition.users.each do |user|
        Rank.create!(user: user, race: self)
      end
    end
end
