# frozen_string_literal: true
module Competitions
  class Update
    attr_reader :competition, :updated_tracks

    def initialize(competition, params)
      @competition = competition
      @params = params
      @updated_tracks = []
    end

    def call
      competition.assign_attributes(competition_params)
      update_cities(competition, sanitized_params)
      update_tracks

      ActiveRecord::Base.transaction(requires_new: true) do
        updated_tracks.each do |t|
          t.save!
        end
        competition.save!
      end

      self
    rescue ActiveRecord::ActiveRecordError
      self
    end

    private

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
        sanitized_params[:tracks_attributes].each do |track_attributes|
          track_attributes = track_attributes.second

          if track_attributes[:id]
            # existing track
            track = Track.find(track_attributes[:id])
            track.assign_attributes(start_time: track_attributes[:start_time])
          else
            # new track
            track = Track.new(start_time: track_attributes[:start_time],
                              competition: competition)
          end

          update_cities(track, track_attributes)
          updated_tracks << track
        end
      end

      def competition_params
        sanitized_params.slice(:name, :start_date, :end_date, :start_registration,
                               :end_registration, :published, :finished,
                               :description, :default_registration_status, :video)
      end

      def sanitized_params
        @params.require(:competition).permit(
          :name, :start_date, :end_date, :start_registration,
          :end_registration, :published, :finished, :description,
          :default_registration_status, :video,
          start_city_attributes: [:id, :name, :street_number, :route, :locality,
                                  :administrative_area_level_2,
                                  :administrative_area_level_1,
                                  :administrative_area_level_1_short,
                                  :country, :country_short, :postal_code],
          end_city_attributes: [:id, :name, :street_number, :route, :locality,
                                :administrative_area_level_2,
                                :administrative_area_level_1,
                                :administrative_area_level_1_short,
                                :country, :country_short, :postal_code],
          tracks_attributes: [:id, :start_time,
                              start_city_attributes: [:id, :name, :street_number,
                                                      :route, :locality,
                                                      :administrative_area_level_2,
                                                      :administrative_area_level_1,
                                                      :administrative_area_level_1_short,
                                                      :country, :country_short, :postal_code],
                              end_city_attributes: [:id, :name, :street_number,
                                                    :route, :locality,
                                                    :administrative_area_level_2,
                                                    :administrative_area_level_1,
                                                    :administrative_area_level_1_short,
                                                    :country, :country_short, :postal_code]]
        )
      end
  end
end
