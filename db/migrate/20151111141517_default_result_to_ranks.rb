class DefaultResultToRanks < ActiveRecord::Migration
  def change
    change_column :ranks, :result, :integer, default: 0

    Rank.reset_column_information
  end
end
