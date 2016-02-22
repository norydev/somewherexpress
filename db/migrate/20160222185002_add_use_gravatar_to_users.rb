class AddUseGravatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :use_gravatar, :boolean, null: false, default: false
  end
end
