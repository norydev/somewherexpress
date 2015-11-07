class AddRaceToRanks < ActiveRecord::Migration
  def change
    add_reference :ranks, :race, polymorphic: true, index: true

    Rank.reset_column_information
    Rank.update_all(race_type: "Track")
    Rank.update_all("race_id = track_id")

    remove_reference :ranks, :track, index: true, foreign_key: true
  end
end
