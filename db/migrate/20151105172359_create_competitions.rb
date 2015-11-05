class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :start_location
      t.string :end_location

      t.timestamps null: false
    end
  end
end
