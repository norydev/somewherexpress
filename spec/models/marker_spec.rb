# frozen_string_literal: true
require "rails_helper"

RSpec.describe Marker, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:mono_track_competition) do
    Competition::Create.call(competition: {
                               name: "new competition",
                               published: "1",
                               start_date: 2.weeks.from_now.to_s,
                               end_date: 3.weeks.from_now.to_s,
                               start_registration: Time.current,
                               finished: false,
                               start_city: { name: "Yverdon, CH",
                                             locality: "Yverdon-Les-Bains",
                                             country_short: "CH" },
                               end_city: { name: "Berne, CH",
                                           locality: "Berne",
                                           country_short: "CH" },
                               tracks: [{ start_time: 16.days.from_now.to_s,
                                          start_city: { name: "Yverdon, CH",
                                                        locality: "Yverdon-Les-Bains",
                                                        country_short: "CH" },
                                          end_city: { name: "Berne, CH",
                                                      locality: "Berne",
                                                      country_short: "CH" } }]
                             },
                             current_user: user).model
  end
  let!(:multi_track_competition) do
    Competition::Create.call(competition: {
                               name: "new competition",
                               published: "1",
                               start_date: 2.weeks.from_now.to_s,
                               end_date: 3.weeks.from_now.to_s,
                               start_registration: Time.current,
                               finished: false,
                               start_city: { name: "Yverdon, CH",
                                             locality: "Yverdon-Les-Bains",
                                             country_short: "CH" },
                               end_city: { name: "Zurich, CH",
                                           locality: "Zurich",
                                           country_short: "CH" },
                               tracks: [{ start_time: 16.days.from_now.to_s,
                                          start_city: { name: "Yverdon, CH",
                                                        locality: "Yverdon-Les-Bains",
                                                        country_short: "CH" },
                                          end_city: { name: "Berne, CH",
                                                      locality: "Berne",
                                                      country_short: "CH" } },
                                         { start_time: 16.days.from_now.to_s,
                                          start_city: { name: "Berne, CH",
                                                        locality: "Zurich",
                                                        country_short: "CH" },
                                          end_city: { name: "Zurich, CH",
                                                      locality: "Zurich",
                                                      country_short: "CH" } }]
                             },
                             current_user: user).model
  end

  describe "mono track route" do
    it "renders 2 markers" do
      markers = Marker.for_route(mono_track_competition)

      expect(markers.size).to eq 2
    end

    it "serializes lat, lng, and picture having url, width, height" do
      markers = Marker.for_route(mono_track_competition)

      expect(markers.first.keys).to contain_exactly(:lat, :lng, :picture)
      expect(markers.first[:picture].keys)
        .to contain_exactly("url", "width", "height")
    end
  end

  describe "multi track route" do
    it "renders the correct number of markers" do
      markers = Marker.for_route(multi_track_competition)

      expect(markers.size).to eq 3
    end
  end
end
