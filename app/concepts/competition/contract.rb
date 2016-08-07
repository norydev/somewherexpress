# frozen_string_literal: true
class Competition < ActiveRecord::Base
  module Contract
    class Create < Reform::Form
      model :competition

      property :name
      property :start_date
      property :end_date
      property :start_registration
      property :end_registration
      property :published
      property :finished
      property :description
      property :default_registration_status
      property :video

      validates :name, presence: true
      validates :start_registration, :start_city, :end_city,
                :start_date, :end_date, presence: { if: :published? }

      property :start_city, populate_if_empty: :populate_city! do
        property :name
        property :street_number
        property :route
        property :locality
        property :administrative_area_level_2
        property :administrative_area_level_1
        property :administrative_area_level_1_short
        property :country
        property :country_short
        property :postal_code
        property :picture
      end

      property :end_city, populate_if_empty: :populate_city! do
        property :name
        property :street_number
        property :route
        property :locality
        property :administrative_area_level_2
        property :administrative_area_level_1
        property :administrative_area_level_1_short
        property :country
        property :country_short
        property :postal_code
        property :picture
      end

      collection :tracks, prepopulator: :prepopulate_tracks!, populate_if_empty: :populate_track!, inherit: true do
        def new_record?
          !model.persisted?
        end

        property :start_time

        validates :start_city, :end_city, :start_time, presence: true

        property :start_city, populate_if_empty: :populate_city! do
          property :name
          property :street_number
          property :route
          property :locality
          property :administrative_area_level_2
          property :administrative_area_level_1
          property :administrative_area_level_1_short
          property :country
          property :country_short
          property :postal_code
          property :picture
        end

        property :end_city, populate_if_empty: :populate_city! do
          property :name
          property :street_number
          property :route
          property :locality
          property :administrative_area_level_2
          property :administrative_area_level_1
          property :administrative_area_level_1_short
          property :country
          property :country_short
          property :postal_code
          property :picture
        end

        private

          def populate_city!(options)
            return City.new unless options[:fragment] && options[:fragment][:locality] && options[:fragment][:name]

            city = City.order(:created_at).find_by(locality: options[:fragment][:locality])

            return city if city
            City.new(options[:fragment])
          end
      end

      private

        def published?
          published && published != "0"
        end

        def prepopulate_tracks!(_options)
          2.times do
            track = Track.new
            track.build_start_city
            track.build_end_city
            tracks << track
          end
        end

        def populate_city!(options)
          return City.new unless options[:fragment] && options[:fragment][:locality] && options[:fragment][:name]

          city = City.order(:created_at).find_by(locality: options[:fragment][:locality])

          return city if city
          City.new(options[:fragment])
        end

        def populate_track!(options)
          Track.new(start_time: options[:fragment][:start_time])
        end
    end
  end
end
