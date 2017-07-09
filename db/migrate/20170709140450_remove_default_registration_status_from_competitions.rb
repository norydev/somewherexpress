class RemoveDefaultRegistrationStatusFromCompetitions < ActiveRecord::Migration[5.0]
  def change
    remove_column :competitions, :default_registration_status, default: "pending", null: false
  end
end
