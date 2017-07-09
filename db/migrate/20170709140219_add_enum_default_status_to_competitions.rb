class AddEnumDefaultStatusToCompetitions < ActiveRecord::Migration[5.0]
  def up
    add_column :competitions, :default_status, :integer, default: 0, null: false

    Competition.where(default_registration_status: "pending")
               .update_all(default_status: 0)
    Competition.where(default_registration_status: "accepted")
               .update_all(default_status: 1)
  end

  def down
    Competition.where(default_status: 0)
               .update_all(default_registration_status: "pending")
    Competition.where(default_status: 1)
               .update_all(default_registration_status: "accepted")

    remove_column :competitions, :default_status, :integer, default: 0, null: false
  end
end
