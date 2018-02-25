# frozen_string_literal: true
class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @markers = Marker.for_all_relevant_cities
    @open_competitions = Competition.published.not_finished.open_for_registration
    @closed_competitions = Competition.published.not_finished.not_open_for_registration
    @past_competitions = Competition.published.finished
                                    .preload(:start_city, :end_city,
                                             tracks: :end_city)

    if user_signed_in?
      render "dashboard"
    else
      @members = User.with_competitions.left_outer_joins(:badges)
                     .order("count(badges) desc").group("users.id")

      @hof_users = User.hall_of_fame
                       .limit(5)
                       .preload(:competition_victories, :badges,
                                track_victories: [:start_city, :end_city])
      render "index", layout: "home"
    end
  end

  def rules; end
end
