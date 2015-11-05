class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :competition, index: true, foreign_key: true
      t.datetime :start_time
      t.string :start_location
      t.string :end_location

      t.timestamps null: false
    end
  end
end
