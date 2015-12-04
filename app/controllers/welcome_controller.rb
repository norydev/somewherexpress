class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @markers = []
    # .first: I know they all started in the same place
    # refactor: new table cities
    @markers = Gmaps4rails.build_markers(City.on_map.uniq{ |m| "#{m[:lat]}-#{m[:lng]}" }) do |city, marker|
      marker.lat city.lat
      marker.lng city.lng
      marker.picture({
          "url" => ActionController::Base.helpers.asset_path("marker.svg"),
          "width" =>  32,
          "height" => 32})
      marker.infowindow render_to_string(partial: "/welcome/map_box", locals: {cities: City.where(lat: city.lat, lng: city.lng), end_cities: City.where(lat: city.lat, lng: city.lng, localizable_type: "Track", order: "end")})
    end
    # @markers += Gmaps4rails.build_markers(policy_scope(Competition).where(finished: true).first) do |competition, marker|
    #   marker.lat competition.start_location_lat
    #   marker.lng competition.start_location_lng
    #   marker.picture({
    #       "url" => ActionController::Base.helpers.asset_path("marker.svg"),
    #       "width" =>  32,
    #       "height" => 32})
    #   marker.infowindow render_to_string(:partial => "/welcome/map_box", locals: {track: false, competition: "many", city: competition.start_location_locality})
    # end
    # @markers += Gmaps4rails.build_markers(policy_scope(Competition).where(finished: true)) do |competition, marker|
    #   marker.lat competition.end_location_lat
    #   marker.lng competition.end_location_lng
    #   marker.picture({
    #       "url" => ActionController::Base.helpers.asset_path("marker.svg"),
    #       "width" =>  32,
    #       "height" => 32})
    #   marker.infowindow render_to_string(:partial => "/welcome/map_box", locals: {track: false, competition: competition, city: competition.start_location_locality})
    # end
    # @markers += Gmaps4rails.build_markers(policy_scope(Track).joins(:competition).where('competitions.finished = true')) do |track, marker|
    #   marker.lat track.end_location_lat
    #   marker.lng track.end_location_lng
    #   marker.picture({
    #       "url" => ActionController::Base.helpers.asset_path("marker.svg"),
    #       "width" =>  32,
    #       "height" => 32})
    #   marker.infowindow render_to_string(:partial => "/welcome/map_box", locals: {track: track, competition: track.competition, city: track.end_location_locality})
    # end
    # @markers = @markers.uniq
    if user_signed_in?
      render 'dashboard'
    else
      render 'index', layout: 'home'
    end
  end

  def rules
  end
end
