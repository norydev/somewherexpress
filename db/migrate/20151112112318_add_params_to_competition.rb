class AddParamsToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :published, :boolean, default: false, null: false
    add_column :competitions, :start_registration, :datetime
    add_column :competitions, :stop_registration, :datetime
  end
end
