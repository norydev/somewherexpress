# frozen_string_literal: true
require "rails_helper"

RSpec.describe Competition::Update do
  let!(:user) { FactoryBot.create(:user) }

  it "updates a competition" do
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

    Competition::Update.call(id: competition.id,
                             competition: { name: "updated name" },
                             current_user: user)

    competition.reload
    expect(competition.name).to eq("updated name")
  end
end
