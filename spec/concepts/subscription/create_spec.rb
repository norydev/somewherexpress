# frozen_string_literal: true
require "rails_helper"

RSpec.describe Subscription::Create do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:competition) do
    Competition::Create
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
  end

  it "creates a subscription" do
    subscription = Subscription::Create
                   .call(subscription: { rules: "1", status: "pending" },
                         current_user: user,
                         competition: competition)
                   .model

    expect(subscription).to be_persisted
    expect(subscription.status).to eq "pending"
    expect(subscription.user).to eq user
    expect(subscription.competition).to eq competition
  end

  it "does not create if status invalid" do
    expect {
      Subscription::Create
        .call(subscription: { rules: "1", status: "hacked" },
              current_user: user,
              competition: competition)
    }.to raise_error Trailblazer::Operation::InvalidContract
  end

  it "does not create if rules not accepted" do
    expect {
      Subscription::Create
        .call(subscription: { rules: "0", status: "pending" },
              current_user: user,
              competition: competition)
        .model
    }.to raise_error Trailblazer::Operation::InvalidContract
  end
end
