class AddAuthorToCompetition < ActiveRecord::Migration
  def change
    add_reference :competitions, :author, references: :users
    add_foreign_key :competitions, :users, column: :author_id
  end
end
