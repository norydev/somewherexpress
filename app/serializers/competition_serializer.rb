# frozen_string_literal: true
#
# This class is meant to serialze competition data to display routes on a map.
# JSON Serialized competition(s) can be passed to GoogleMaps API.
class CompetitionSerializer
  attr_reader :competition

  def initialize(competition)
    @competition = competition
  end

  def as_json(*_args)
    competition.slice(:id, :name)
               .merge(start_city: city_serialized(competition.start_city),
                      end_city:   city_serialized(competition.end_city),
                      tracks:     competition.tracks.map { |track| track_serialized(track) })
  end

  private

    def city_serialized(city)
      city.slice(:lat, :lng, :name)
    end

    def track_serialized(track)
      { end_city: track.end_city.slice(:name) }
    end
end
