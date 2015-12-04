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
    all.select { |c| c.competition.finished? }
  end
end
