class AddDsqToRanks < ActiveRecord::Migration
  def change
    add_column :ranks, :dsq, :boolean, default: false, null: false
  end
end
