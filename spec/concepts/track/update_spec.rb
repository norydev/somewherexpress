# frozen_string_literal: true
require "rails_helper"

RSpec.describe Track::Contract::Update do
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

    4.times do
      u = FactoryBot.create(:user)
      FactoryBot.create(:subscription, user: u, competition: competition)
    end

    track = competition.tracks.first

    form = described_class.new(track)

    form.save if form.validate(ranks: [
                                 {
                                   id: track.ranks[0].id,
                                   points: 2,
                                   result: 1,
                                   dsq: "0"
                                 },
                                 {
                                   id: track.ranks[1].id,
                                   points: 2,
                                   result: 1,
                                   dsq: "0"
                                 },
                                 {
                                   id: track.ranks[2].id,
                                   points: 1,
                                   result: 2,
                                   dsq: "0"
                                 },
                                 {
                                   id: track.ranks[3].id,
                                   points: 0,
                                   result: 0,
                                   dsq: "1"
                                 }
                               ])

    track.reload
    expect(track.ranks.where(result: 1).size).to eq 2
    expect(track.ranks.where(points: 1).size).to eq 1
    expect(track.ranks.where(dsq: true).size).to eq 1
  end
end
