class AddPictureToCities < ActiveRecord::Migration
  def change
    add_column :cities, :picture, :string
  end
end
