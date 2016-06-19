class CleanCityModel < ActiveRecord::Migration
  def change
    City.nowhere.each do |c|
      c.destroy
    end

    remove_column :cities, :localizable_id, :integer
    remove_column :cities, :localizable_type, :string
    remove_column :cities, :order, :string, null: false, default: "start"
  end
end
