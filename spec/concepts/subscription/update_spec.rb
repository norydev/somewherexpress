# frozen_string_literal: true
require "rails_helper"

RSpec.describe Subscription::Update do
  let!(:user) { FactoryBot.create(:user) }
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
                   .call(subscription: { rules: "1", status: "pending",
                                         user_attributes: {
                                           phone_number: "+41791234455",
                                           whatsapp: "0",
                                           telegram: "0",
                                           signal: "0"
                                         } },
                         current_user: user,
                         competition_id: competition.id)
                   .model

    described_class.call(id: subscription.id,
                         subscription: { status: "accepted" },
                         current_user: user)

    expect(subscription.reload.status).to eq "accepted"
  end

  it "does not update if invalid status" do
    subscription = Subscription::Create
                   .call(subscription: { rules: "1", status: "pending",
                                         user_attributes: {
                                           phone_number: "+41791234455",
                                           whatsapp: "0",
                                           telegram: "0",
                                           signal: "0"
                                         } },
                         current_user: user,
                         competition_id: competition.id)
                   .model

    expect {
      described_class.call(id: subscription.id,
                           subscription: { status: "undecided" },
                           current_user: user)
    }.to change(Subscription, :count).by(0)
  end
end
