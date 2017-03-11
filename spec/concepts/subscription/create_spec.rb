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
                   .call(subscription: { rules: "1", status: "pending",
                                         user: {
                                           phone_number: "+41791234455",
                                           whatsapp: "0",
                                           telegram: "0",
                                           signal: "0"
                                         } },
                         current_user: user,
                         competition_id: competition.id)
                   .model

    expect(subscription).to be_persisted
    expect(subscription.status).to eq "pending"
    expect(subscription.user).to eq user
    expect(subscription.competition).to eq competition
  end

  it "does not create if status invalid" do
    expect {
      Subscription::Create
        .call(subscription: { rules: "1", status: "hacked",
                              user: {
                                whatsapp: "0",
                                telegram: "0",
                                signal: "0"
                              } },
              current_user: user,
              competition_id: competition.id)
    }.to raise_error Trailblazer::Operation::InvalidContract
  end

  it "does not create if rules not accepted" do
    subscription = Subscription::Create
                   .call(subscription: { rules: "0", status: "pending",
                                         user: {
                                           whatsapp: "0",
                                           telegram: "0",
                                           signal: "0"
                                         } },
                         current_user: user,
                         competition_id: competition.id)
                   .model

    expect(subscription).not_to be_persisted
    expect(subscription.errors.details).to include(rules: [{ error: :accepted }])
  end
end
