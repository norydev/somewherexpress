class ChangeUsersSeCommitteeToOrganizer < ActiveRecord::Migration
  def change
    rename_column :users, :se_committee, :organizer
  end
end
