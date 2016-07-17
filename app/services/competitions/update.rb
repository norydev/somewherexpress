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
        updated_tracks.each(&:save!)
        competition.save!
      end

      self
    rescue ActiveRecord::ActiveRecordError
      self
    end

    private

      def update_city(obj, param, side = "start")
        raise ActiveRecord::ActiveRecordError unless ["start", "end"].include?(side)

        city = City.order(:created_at).find_by(locality: param[:locality])

        if city
          obj.assign_attributes("#{side}_city".to_sym => city)
        else
          obj.send("build_#{side}_city", param.except(:id))
        end
      end

      def update_cities(obj, param)
        update_city(obj, param[:start_city_attributes], "start")
        update_city(obj, param[:end_city_attributes], "end")
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
                                  :country, :country_short, :postal_code, :picture],
          end_city_attributes: [:id, :name, :street_number, :route, :locality,
                                :administrative_area_level_2,
                                :administrative_area_level_1,
                                :administrative_area_level_1_short,
                                :country, :country_short, :postal_code, :picture],
          tracks_attributes: [:id, :start_time,
                              start_city_attributes: [:id, :name, :street_number,
                                                      :route, :locality,
                                                      :administrative_area_level_2,
                                                      :administrative_area_level_1,
                                                      :administrative_area_level_1_short,
                                                      :country, :country_short,
                                                      :postal_code, :picture],
                              end_city_attributes: [:id, :name, :street_number,
                                                    :route, :locality,
                                                    :administrative_area_level_2,
                                                    :administrative_area_level_1,
                                                    :administrative_area_level_1_short,
                                                    :country, :country_short,
                                                    :postal_code, :picture]]
        )
      end
  end
end
