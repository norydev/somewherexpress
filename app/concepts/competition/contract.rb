# frozen_string_literal: true
class Competition < ActiveRecord::Base
  module Contract
    class Create < Reform::Form
      include ActiveModel::ModelReflections
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

      property :start_city, prepopulator: :prepopulate_start_city!,
                            populate_if_empty: :populate_city!,
                            form: City::Form

      property :end_city, prepopulator: :prepopulate_end_city!,
                          populate_if_empty: :populate_city!,
                          form: City::Form

      collection :tracks, prepopulator: :prepopulate_tracks!, populate_if_empty: :populate_track!, inherit: true do
        def new_record?
          !model.persisted?
        end

        property :start_time

        validates :start_city, :end_city, :start_time, presence: true

        property :start_city, populate_if_empty: :populate_city!,
                              form: City::Form

        property :end_city, populate_if_empty: :populate_city!,
                            form: City::Form

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
          track = Track.new
          track.build_start_city
          track.build_end_city
          tracks << track
        end

        def populate_city!(options)
          return City.new unless options[:fragment] && options[:fragment][:locality] && options[:fragment][:name]

          city = City.order(:created_at).find_by(locality: options[:fragment][:locality])

          return city if city
          City.new(options[:fragment])
        end

        def prepopulate_start_city!(_options)
          return if start_city
          self.start_city = City.new
        end

        def prepopulate_end_city!(_options)
          return if end_city
          self.end_city = City.new
        end

        def populate_track!(options)
          Track.new(start_time: options[:fragment][:start_time])
        end
    end

    class Update < Create
      private

        def prepopulate_tracks!(_options)
          tracks = tracks
        end
    end
  end
end
