# frozen_string_literal: true
class Competitions::Update
  attr_reader :competition

  def initialize(competition, params)
    @competition = competition
    @params = params
  end

  def call
    ActiveRecord::Base.transaction(requires_new: true) do
      competition.assign_attributes(competition_params)
      update_cities(@competition, @params)
      @competition.save!
      update_tracks
    end

    self
  rescue ActiveRecord::ActiveRecordError
    self
  end

  private

    attr_reader :params

    def update_cities(obj, param)
      start_city = City.order(:created_at).find_by(locality: param[:start_city_attributes][:locality])

      if start_city
        obj.assign_attributes(start_city: start_city)
      else
        obj.build_start_city(param[:start_city_attributes].except(:id))
      end

      end_city = City.order(:created_at).find_by(locality: param[:end_city_attributes][:locality])

      if end_city
        obj.assign_attributes(end_city: end_city)
      else
        obj.build_end_city(param[:end_city_attributes].except(:id))
      end
    end

    def update_tracks
      params[:tracks_attributes].each do |track_attributes|
        track_attributes = track_attributes.second

        if track_attributes[:id]
          # existing track
          track = Track.find(track_attributes[:id])
          track.assign_attributes(start_time: track_attributes[:start_time])

          update_cities(track, track_attributes)
        else
          # new track
          track = competition.tracks.new(start_time: track_attributes[:start_time])

          update_cities(track, track_attributes)
        end
        track.save!
      end
    end

    def competition_params
      params.slice(:name, :start_date, :end_date, :start_registration,
                   :end_registration, :published, :finished, :description,
                   :default_registration_status, :video)
    end
end
