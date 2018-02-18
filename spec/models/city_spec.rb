# frozen_string_literal: true
# == Schema Information
#
# Table name: cities
#
#  id                                :integer          not null, primary key
#  name                              :string
#  street_number                     :string
#  route                             :string
#  locality                          :string
#  administrative_area_level_2       :string
#  administrative_area_level_1       :string
#  administrative_area_level_1_short :string
#  country                           :string
#  country_short                     :string
#  postal_code                       :string
#  lat                               :float
#  lng                               :float
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  picture                           :string
#

require "rails_helper"

RSpec.describe City, type: :model do
  describe "scopes" do
    before(:each) do
      paris = FactoryGirl.create(:city, name: "Paris")
      belgrade = FactoryGirl.create(:city, name: "Belgrade")
      istanbul = FactoryGirl.create(:city, name: "Istanbul")
      sofia = FactoryGirl.create(:city, name: "Sofia")
      berlin = FactoryGirl.create(:city, name: "Berlin")
      bucharest = FactoryGirl.create(:city, name: "Bucharest")

      # finished
      FactoryGirl.create(
        :competition, published: true, start_city: paris, end_city: istanbul,
                      author: FactoryGirl.create(:user),
                      tracks: [
                        Track.new(start_city: paris, end_city: belgrade),
                        Track.new(start_city: belgrade, end_city: sofia)
                      ]
      )

      # unfinished
      FactoryGirl.create(
        :competition, finished: false, start_city: berlin, end_city: bucharest,
                      author: FactoryGirl.create(:user),
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
