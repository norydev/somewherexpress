class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @markers = Gmaps4rails.build_markers(City.all.on_map.uniq { |m| "#{m[:lat]}-#{m[:lng]}" }) do |city, marker|
      marker.lat city.lat
      marker.lng city.lng
      marker.picture({
          "url" => ActionController::Base.helpers.asset_path("marker.svg"),
          "width" =>  32,
          "height" => 32 })
      marker.infowindow render_to_string(partial: "/welcome/map_box", locals: { cities: City.where(lat: city.lat, lng: city.lng).on_map, end_cities: City.where(lat: city.lat, lng: city.lng, localizable_type: "Track", order: "end").on_map })
    end
    if user_signed_in?
      render 'dashboard'
    else
      render 'index', layout: 'home'
    end
  end

  def rules
  end
end
