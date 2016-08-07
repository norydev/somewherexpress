# frozen_string_literal: true
require "rails_helper"

RSpec.describe Competition::Create do
  it "creates an unpublished competition" do
    competition = Competition::Create
                    .(competition: {name: "new competition", published: false})
                  .model

    expect(competition).to be_persisted
    expect(competition.name).to eq "new competition"
    expect(competition.published).to be false
  end

  it "does not create an unpublished competition without name" do
    expect {
      Competition::Create.call(competition: { name: "", published: false })
    }.to raise_error Trailblazer::Operation::InvalidContract
  end

  it "creates a published competition" do
    competition = Competition::Create
                  .(competition: {
                      name: "new competition",
                      published: true,
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
                    })
                  .model

    expect(competition).to be_persisted
    expect(competition.published).to be true
  end
end
