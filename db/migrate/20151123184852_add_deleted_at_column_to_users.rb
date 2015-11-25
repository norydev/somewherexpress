class AddDeletedAtColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :datetime
    add_column :users, :old_first_name, :string
    add_column :users, :old_last_name, :string
    add_column :users, :old_email, :string
  end
end
