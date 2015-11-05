class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.references :track, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :result
      t.integer :points

      t.timestamps null: false
    end
  end
end
