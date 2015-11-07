class AddCoordinatesToCompetitionsAndTracks < ActiveRecord::Migration
  def change
    add_column :competitions, :start_location_lat, :float
    add_column :competitions, :start_location_lng, :float
    add_column :competitions, :end_location_lat, :float
    add_column :competitions, :end_location_lng, :float
    add_column :tracks, :start_location_lat, :float
    add_column :tracks, :start_location_lng, :float
    add_column :tracks, :end_location_lat, :float
    add_column :tracks, :end_location_lng, :float
  end
end
