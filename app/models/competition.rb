class Competition < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :tracks, dependent: :destroy
  accepts_nested_attributes_for :tracks

  has_many :ranks, as: :race, dependent: :destroy

  before_validation :geocoding, if: :location_changed?

  def to_s
    name
  end

  def t_ranks
    tracks.map{ |t| t.ranks }.flatten
  end

  private

    def geocoding
      start_geo = Geocoder.search(start_location)
      end_geo = Geocoder.search(end_location)
      self.start_location_lat = start_geo.first.data["geometry"]["location"]["lat"]
      self.start_location_lng = start_geo.first.data["geometry"]["location"]["lng"]
      self.end_location_lat = end_geo.first.data["geometry"]["location"]["lat"]
      self.end_location_lng = end_geo.first.data["geometry"]["location"]["lng"]
    end

    def location_changed?
      start_location_changed? || end_location_changed?
    end
end
