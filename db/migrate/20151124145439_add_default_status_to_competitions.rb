class AddDefaultStatusToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :default_registration_status, :string, null: false, default: "pending"
  end
end
