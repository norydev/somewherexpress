class RemoveUnnecessaryCityAttrs < ActiveRecord::Migration[5.0]
  def change
    remove_column :cities, :street_number, :string
    remove_column :cities, :route, :string
    remove_column :cities, :administrative_area_level_2, :string
    remove_column :cities, :administrative_area_level_1, :string
    remove_column :cities, :administrative_area_level_1_short, :string
    remove_column :cities, :country, :string
    remove_column :cities, :postal_code, :string
  end
end
