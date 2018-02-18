# frozen_string_literal: true
class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @markers = Marker.for_all_relevant_cities

    if user_signed_in?
      render "dashboard"
    else
      render "index", layout: "home"
    end
  end

  def rules; end
end
