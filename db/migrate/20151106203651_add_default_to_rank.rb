class AddDefaultToRank < ActiveRecord::Migration
  def change
    change_column :ranks, :points, :integer, default: 0

    Rank.reset_column_information
  end
end
