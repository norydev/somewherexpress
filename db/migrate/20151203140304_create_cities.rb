class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :street_number
      t.string :route
      t.string :locality
      t.string :administrative_area_level_2
      t.string :administrative_area_level_1
      t.string :administrative_area_level_1_short
      t.string :country
      t.string :country_short
      t.string :postal_code
      t.float :lat
      t.float :lng
      t.references :localizable, polymorphic: true, index: true
      t.string :order, default: "start", null: false

      t.timestamps null: false
    end
  end
end


