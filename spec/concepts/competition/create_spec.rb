# frozen_string_literal: true
require "rails_helper"

RSpec.describe Competition::Create do
  it "creates an unpublished competition" do
    competition = Competition::Create
                  .call(competition: { name: "new competition", published: "0" })
                  .model

    expect(competition).to be_persisted
    expect(competition.name).to eq "new competition"
    expect(competition.published).to be false
  end

  it "does not create an unpublished competition without name" do
    expect {
      Competition::Create.call(competition: { name: "", published: "0" })
    }.to raise_error Trailblazer::Operation::InvalidContract
  end

  let!(:user) { FactoryBot.create(:user) }
  let!(:existing_city) do
    FactoryBot.create(:city, locality: "Berne", name: "Berne, CH")
  end

  it "creates a published competition" do
    competition = Competition::Create
                  .call(competition: {
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
                        current_user: user)
                  .model

    expect(competition).to be_persisted
    expect(competition.author).to eq user
    expect(competition.start_city.locality).to eq "Yverdon-Les-Bains"
    expect(competition.tracks.size).to eq 1
    expect(competition.tracks.first.end_city.id).to eq existing_city.id
    expect(competition.end_city.id).to eq existing_city.id
  end
end
