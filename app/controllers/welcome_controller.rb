class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    if user_signed_in?
      @open_competitions = policy_scope(Competition).where(finished: false).order(:start_date).select{ |c| c.registrations_open? }
      render 'dashboard'
    else
      @markers = []
      @markers << Gmaps4rails.build_markers(policy_scope(Competition).where(finished: true)) do |competition, marker|
        marker.lat competition.start_location_lat
        marker.lng competition.start_location_lng
        marker.picture({
            "url" => ActionController::Base.helpers.asset_path("marker.svg"),
            "width" =>  32,
            "height" => 32})
      end
      @markers << Gmaps4rails.build_markers(policy_scope(Competition).where(finished: true)) do |competition, marker|
        marker.lat competition.end_location_lat
        marker.lng competition.end_location_lng
        marker.picture({
            "url" => ActionController::Base.helpers.asset_path("marker.svg"),
            "width" =>  32,
            "height" => 32})
      end
      @markers << Gmaps4rails.build_markers(policy_scope(Track).joins(:competition).where('competitions.finished = true')) do |track, marker|
        marker.lat track.start_location_lat
        marker.lng track.start_location_lng
        marker.picture({
            "url" => ActionController::Base.helpers.asset_path("marker.svg"),
            "width" =>  32,
            "height" => 32})
      end
      @markers << Gmaps4rails.build_markers(policy_scope(Track).joins(:competition).where('competitions.finished = true')) do |track, marker|
        marker.lat track.end_location_lat
        marker.lng track.end_location_lng
        marker.picture({
            "url" => ActionController::Base.helpers.asset_path("marker.svg"),
            "width" =>  32,
            "height" => 32})
      end
      @markers = @markers.flatten.uniq
      render 'index'
    end
  end
end
