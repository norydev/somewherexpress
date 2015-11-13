class Competition < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :tracks, dependent: :destroy
  accepts_nested_attributes_for :tracks, allow_destroy: true

  has_many :ranks, as: :race, dependent: :destroy

  before_validation :geocoding, if: :location_changed?

  def to_s
    name
  end

  def multiple_tracks?
    self.tracks.size > 1
  end

  def t_ranks
    Rank.where(race_id: self.tracks.map(&:id), race_type: "Track")
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
end
