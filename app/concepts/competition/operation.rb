# frozen_string_literal: true
class Competition < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model
    model Competition, :create

    contract do
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
      validates :start_registration, :start_city, :end_city, :start_date, :end_date, presence: { if: :published }

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

      collection :tracks, prepopulator: :prepopulate_tracks, populate_if_empty: :populate_track! do
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
            return City.new(options[:fragment])
          end
      end

      private

        def prepopulate_tracks!(_options)
          2.times { tracks << track.new }
        end

        def populate_city!(options)
          return City.new unless options[:fragment] && options[:fragment][:locality] && options[:fragment][:name]

          city = City.order(:created_at).find_by(locality: options[:fragment][:locality])

          return city if city
          return City.new(options[:fragment])
        end

        def populate_track!(_options)
          Track.new
        end
    end

    def process(params)
      validate(params[:competition], &:save)
    end

    private

      def setup_model!(params)
        model.author = params[:current_user]
      end
  end
end
