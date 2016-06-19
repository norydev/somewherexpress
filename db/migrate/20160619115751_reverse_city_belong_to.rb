class ReverseCityBelongTo < ActiveRecord::Migration
  def change
    add_column :tracks, :start_city_id, :integer
    add_column :tracks, :end_city_id, :integer

    add_foreign_key :tracks, :cities, column: :start_city_id
    add_foreign_key :tracks, :cities, column: :end_city_id

    add_index :tracks, [:start_city_id, :end_city_id]

    add_column :competitions, :start_city_id, :integer
    add_column :competitions, :end_city_id, :integer

    add_foreign_key :competitions, :cities, column: :start_city_id
    add_foreign_key :competitions, :cities, column: :end_city_id

    add_index :competitions, [:start_city_id, :end_city_id]
  end
end
