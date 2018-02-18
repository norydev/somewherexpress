class CleanCityModel < ActiveRecord::Migration
  def change
    c1 = City.joins(:start_of_competitions).ids
    c2 = City.joins(:end_of_competitions).ids
    c3 = City.joins(:start_of_tracks).ids
    c4 = City.joins(:end_of_tracks).ids

    City.where.not(id: c1 | c2 | c3 | c4).each do |c|
      c.destroy
    end

    remove_column :cities, :localizable_id, :integer
    remove_column :cities, :localizable_type, :string
    remove_column :cities, :order, :string, null: false, default: "start"
  end
end
