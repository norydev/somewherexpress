class RenameEnumStatusInSubscriptions < ActiveRecord::Migration[5.0]
  def change
    rename_column :subscriptions, :enum_status, :status
  end
end
