# frozen_string_literal: true
class Marker
  def self.for_all_relevant_cities
    for_cities(City.on_map)
  end

  def self.for_route(competition)
    tracks_cities = competition.tracks.flat_map { |t| [t.start_city, t.end_city] }

    route_cities = [competition.start_city, competition.end_city, tracks_cities].flatten.uniq(&:name)

    simple_for_cities(route_cities)
  end

  def self.for_cities(cities)
    Gmaps4rails.build_markers(
      cities.preload(end_of_tracks: [:competition, ranks: [:user]])
    ) do |city, marker|
      marker.lat city.lat
      marker.lng city.lng
      marker.picture("url" => ActionController::Base.helpers.asset_path("marker.svg"),
                     "width" =>  32,
                     "height" => 32)
      marker.infowindow ApplicationController.render(partial: "/welcome/map_box",
                                                     locals: { city: city })
    end
  end

  def self.simple_for_cities(cities)
    Gmaps4rails.build_markers(cities) do |city, marker|
      marker.lat city.lat
      marker.lng city.lng
      marker.picture("url" => ActionController::Base.helpers.asset_path("marker.svg"),
                     "width" =>  32,
                     "height" => 32)
    end
  end
end
