require "rails_helper"

RSpec.describe CompetitionSerializer do
  let!(:user) { FactoryBot.create(:user) }

  let!(:competition) do
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

  it "has the minimal attributes" do
    serialized = described_class.new(competition).as_json

    expect(serialized.keys).to include("name", "start_city", "end_city", "tracks")
    expect(serialized["start_city"].keys).to include("lat", "lng", "name")
    expect(serialized["end_city"].keys).to include("lat", "lng", "name")
    expect(serialized["tracks"]).to be_an Array
    expect(serialized["tracks"].first.keys).to include("end_city")
    expect(serialized["tracks"].first["end_city"].keys).to include("name")
  end
end
