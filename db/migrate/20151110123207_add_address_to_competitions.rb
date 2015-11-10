class AddAddressToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :start_location_street_number, :string
    add_column :competitions, :start_location_route, :string
    add_column :competitions, :start_location_locality, :string
    add_column :competitions, :start_location_administrative_area_level_2, :string
    add_column :competitions, :start_location_administrative_area_level_1, :string
    add_column :competitions, :start_location_administrative_area_level_1_short, :string
    add_column :competitions, :start_location_country, :string
    add_column :competitions, :start_location_country_short, :string
    add_column :competitions, :start_location_postal_code, :string

    add_column :competitions, :end_location_street_number, :string
    add_column :competitions, :end_location_route, :string
    add_column :competitions, :end_location_locality, :string
    add_column :competitions, :end_location_administrative_area_level_2, :string
    add_column :competitions, :end_location_administrative_area_level_1, :string
    add_column :competitions, :end_location_administrative_area_level_1_short, :string
    add_column :competitions, :end_location_country, :string
    add_column :competitions, :end_location_country_short, :string
    add_column :competitions, :end_location_postal_code, :string
  end
end
