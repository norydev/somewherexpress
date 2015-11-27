class AddVideoToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :video, :string
  end
end
