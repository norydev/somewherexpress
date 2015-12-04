class TransferLocationsToCities < ActiveRecord::Migration
  def up
    City.reset_column_information
    Competition.all.each do |c|
      City.create!(localizable: c, name: c.start_location, street_number: c.start_location_street_number, route: c.start_location_route, locality: c.start_location_locality, administrative_area_level_2: c.start_location_administrative_area_level_2, administrative_area_level_1: c.start_location_administrative_area_level_1, administrative_area_level_1_short: c.start_location_administrative_area_level_1_short, country: c.start_location_country, country_short: c.start_location_country_short, postal_code: c.start_location_postal_code, lat: c.start_location_lat, lng: c.start_location_lng)
      City.create!(localizable: c, name: c.end_location, street_number: c.end_location_street_number, route: c.end_location_route, locality: c.end_location_locality, administrative_area_level_2: c.end_location_administrative_area_level_2, administrative_area_level_1: c.end_location_administrative_area_level_1, administrative_area_level_1_short: c.end_location_administrative_area_level_1_short, country: c.end_location_country, country_short: c.end_location_country_short, postal_code: c.end_location_postal_code, lat: c.end_location_lat, lng: c.end_location_lng, order: "end")
    end
    Track.all.each do |t|
      City.create!(localizable: t, name: t.start_location, street_number: t.start_location_street_number, route: t.start_location_route, locality: t.start_location_locality, administrative_area_level_2: t.start_location_administrative_area_level_2, administrative_area_level_1: t.start_location_administrative_area_level_1, administrative_area_level_1_short: t.start_location_administrative_area_level_1_short, country: t.start_location_country, country_short: t.start_location_country_short, postal_code: t.start_location_postal_code, lat: t.start_location_lat, lng: t.start_location_lng)
      City.create!(localizable: t, name: t.end_location, street_number: t.end_location_street_number, route: t.end_location_route, locality: t.end_location_locality, administrative_area_level_2: t.end_location_administrative_area_level_2, administrative_area_level_1: t.end_location_administrative_area_level_1, administrative_area_level_1_short: t.end_location_administrative_area_level_1_short, country: t.end_location_country, country_short: t.end_location_country_short, postal_code: t.end_location_postal_code, lat: t.end_location_lat, lng: t.end_location_lng, order: "end")
    end

    remove_columns :competitions, :start_location, :start_location_lat, :start_location_lng, :start_location_street_number, :start_location_route, :start_location_locality, :start_location_administrative_area_level_2, :start_location_administrative_area_level_1, :start_location_administrative_area_level_1_short, :start_location_country, :start_location_country_short, :start_location_postal_code, :end_location, :end_location_lat, :end_location_lng, :end_location_street_number, :end_location_route, :end_location_locality, :end_location_administrative_area_level_2, :end_location_administrative_area_level_1, :end_location_administrative_area_level_1_short, :end_location_country, :end_location_country_short, :end_location_postal_code
    remove_columns :tracks, :start_location, :start_location_lat, :start_location_lng, :start_location_street_number, :start_location_route, :start_location_locality, :start_location_administrative_area_level_2, :start_location_administrative_area_level_1, :start_location_administrative_area_level_1_short, :start_location_country, :start_location_country_short, :start_location_postal_code, :end_location, :end_location_lat, :end_location_lng, :end_location_street_number, :end_location_route, :end_location_locality, :end_location_administrative_area_level_2, :end_location_administrative_area_level_1, :end_location_administrative_area_level_1_short, :end_location_country, :end_location_country_short, :end_location_postal_code
  end

  def down
    add_column :competitions, :start_location, :string
    add_column :competitions, :start_location_lat, :float
    add_column :competitions, :start_location_lng, :float
    add_column :competitions, :start_location_street_number, :string
    add_column :competitions, :start_location_route, :string
    add_column :competitions, :start_location_locality, :string
    add_column :competitions, :start_location_administrative_area_level_2, :string
    add_column :competitions, :start_location_administrative_area_level_1, :string
    add_column :competitions, :start_location_administrative_area_level_1_short, :string
    add_column :competitions, :start_location_country, :string
    add_column :competitions, :start_location_country_short, :string
    add_column :competitions, :start_location_postal_code, :string

    add_column :competitions, :end_location, :string
    add_column :competitions, :end_location_lat, :float
    add_column :competitions, :end_location_lng, :float
    add_column :competitions, :end_location_street_number, :string
    add_column :competitions, :end_location_route, :string
    add_column :competitions, :end_location_locality, :string
    add_column :competitions, :end_location_administrative_area_level_2, :string
    add_column :competitions, :end_location_administrative_area_level_1, :string
    add_column :competitions, :end_location_administrative_area_level_1_short, :string
    add_column :competitions, :end_location_country, :string
    add_column :competitions, :end_location_country_short, :string
    add_column :competitions, :end_location_postal_code, :string

    add_column :tracks, :start_location, :string
    add_column :tracks, :start_location_lat, :float
    add_column :tracks, :start_location_lng, :float
    add_column :tracks, :start_location_street_number, :string
    add_column :tracks, :start_location_route, :string
    add_column :tracks, :start_location_locality, :string
    add_column :tracks, :start_location_administrative_area_level_2, :string
    add_column :tracks, :start_location_administrative_area_level_1, :string
    add_column :tracks, :start_location_administrative_area_level_1_short, :string
    add_column :tracks, :start_location_country, :string
    add_column :tracks, :start_location_country_short, :string
    add_column :tracks, :start_location_postal_code, :string

    add_column :tracks, :end_location, :string
    add_column :tracks, :end_location_lat, :float
    add_column :tracks, :end_location_lng, :float
    add_column :tracks, :end_location_street_number, :string
    add_column :tracks, :end_location_route, :string
    add_column :tracks, :end_location_locality, :string
    add_column :tracks, :end_location_administrative_area_level_2, :string
    add_column :tracks, :end_location_administrative_area_level_1, :string
    add_column :tracks, :end_location_administrative_area_level_1_short, :string
    add_column :tracks, :end_location_country, :string
    add_column :tracks, :end_location_country_short, :string
    add_column :tracks, :end_location_postal_code, :string
    Competition.reset_column_information
    Track.reset_column_information

    City.all.each do |c|
      localizable = c.localizable
      if c.order == "start"
        localizable.update!(start_location: c.name, start_location_street_number: c.street_number, start_location_route: c.route, start_location_locality: c.locality, start_location_administrative_area_level_2: c.administrative_area_level_2, start_location_administrative_area_level_1: c.administrative_area_level_1, start_location_administrative_area_level_1_short: c.administrative_area_level_1_short, start_location_country: c.country, start_location_country_short: c.country_short, start_location_postal_code: c.postal_code, start_location_lat: c.lat, start_location_lng: c.lng)
      else
        localizable.update!(end_location: c.name, end_location_street_number: c.street_number, end_location_route: c.route, end_location_locality: c.locality, end_location_administrative_area_level_2: c.administrative_area_level_2, end_location_administrative_area_level_1: c.administrative_area_level_1, end_location_administrative_area_level_1_short: c.administrative_area_level_1_short, end_location_country: c.country, end_location_country_short: c.country_short, end_location_postal_code: c.postal_code, end_location_lat: c.lat, end_location_lng: c.lng)
      end
    end
  end
end
