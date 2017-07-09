class RenameDefaultStatusInCompetitions < ActiveRecord::Migration[5.0]
  def change
    rename_column :competitions, :default_status, :default_registration_status
  end
end
