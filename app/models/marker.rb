class Marker
  def self.for_all_relevant_cities
    on_cities(City.preload(end_of_tracks: [:competition, ranks: [:user]])
                  .on_map
                  .distinct(:locality))
  end

  def self.on_cities(cities)
    Gmaps4rails.build_markers(cities) do |city, marker|
      marker.lat city.lat
      marker.lng city.lng
      marker.picture("url" => ActionController::Base.helpers.asset_path("marker.svg"),
                     "width" =>  32,
                     "height" => 32)
      marker.infowindow ApplicationController.render(partial: "/welcome/map_box",
                                                     locals: { city: city })
    end
  end
end
