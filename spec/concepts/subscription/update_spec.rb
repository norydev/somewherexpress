# frozen_string_literal: true
require "rails_helper"

RSpec.describe Subscription::Update do
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

  it "updates a subscription" do
    subscription = Subscription::Create
                   .call(subscription: { rules: "1", status: "accepted" },
                         current_user: user,
                         competition: competition)
                   .model

    Subscription::Update.call(id: subscription.id,
                              subscription: { status: "accepted" })

    expect(subscription.status).to eq "accepted"
  end

  it "does not update if invalid status" do
    subscription = Subscription::Create
                   .call(subscription: { rules: "1", status: "accepted" },
                         current_user: user,
                         competition: competition)
                   .model

    expect {
      Subscription::Update.call(id: subscription.id,
                                subscription: { status: "undecided" })
    }.to raise_error Trailblazer::Operation::InvalidContract
  end
end
