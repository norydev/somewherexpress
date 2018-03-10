# frozen_string_literal: true
# == Schema Information
#
# Table name: cities
#
#  id            :integer          not null, primary key
#  name          :string
#  locality      :string
#  country_short :string
#  lat           :float
#  lng           :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  picture       :string
#

require "rails_helper"

RSpec.describe City, type: :model do
  describe "scopes" do
    before(:each) do
      paris = FactoryBot.create(:city, name: "Paris")
      belgrade = FactoryBot.create(:city, name: "Belgrade")
      istanbul = FactoryBot.create(:city, name: "Istanbul")
      sofia = FactoryBot.create(:city, name: "Sofia")
      berlin = FactoryBot.create(:city, name: "Berlin")
      bucharest = FactoryBot.create(:city, name: "Bucharest")

      # finished
      FactoryBot.create(
        :competition, published: true, start_city: paris, end_city: istanbul,
                      author: FactoryBot.create(:user),
                      tracks: [
                        Track.new(start_city: paris, end_city: belgrade),
                        Track.new(start_city: belgrade, end_city: sofia)
                      ]
      )

      # unfinished
      FactoryBot.create(
        :competition, finished: false, start_city: berlin, end_city: bucharest,
                      author: FactoryBot.create(:user),
                      tracks: [
                        Track.new(start_city: berlin, end_city: bucharest)
                      ]
      )
    end

    it "scopes on_map correctly" do
      expect(City.on_map.pluck(:name))
        .to contain_exactly("Paris", "Belgrade", "Sofia", "Istanbul")
    end
  end
end
