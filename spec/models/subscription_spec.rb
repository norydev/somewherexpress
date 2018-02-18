# frozen_string_literal: true
# == Schema Information
#
# Table name: subscriptions
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  competition_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :integer          default("pending"), not null
#
# Indexes
#
#  index_subscriptions_on_competition_id  (competition_id)
#  index_subscriptions_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (competition_id => competitions.id)
#  fk_rails_...  (user_id => users.id)
#

require "rails_helper"

RSpec.describe Subscription, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:competition) }

  it "returns the correct nb of points" do
    u = FactoryBot.create :user, email: "u1@yopmail.com"
    c = FactoryBot.create :competition, start_city: FactoryBot.create(:city),
                                        end_city: FactoryBot.create(:city)

    ts = []
    5.times do |n|
      ts[n] = FactoryBot.create :track, competition: c, start_city: FactoryBot.create(:city),
                                        end_city: FactoryBot.create(:city)
    end

    s = FactoryBot.create :subscription, user: u, competition: c

    ts.each do |t|
      r = t.ranks.find_by(user: u)
      r.points = 4
      r.save
    end

    expect(s.points).to eq(20)
  end

  it "returns the correct result" do
    u1 = FactoryBot.create :user, email: "u1@yopmail.com"
    u2 = FactoryBot.create :user, email: "u2@yopmail.com"
    u3 = FactoryBot.create :user, email: "u3@yopmail.com"
    c = FactoryBot.create :competition, start_city: FactoryBot.create(:city),
                                        end_city: FactoryBot.create(:city)
    t = FactoryBot.create :track, competition: c, start_city: FactoryBot.create(:city),
                                  end_city: FactoryBot.create(:city)
    FactoryBot.create :subscription, user: u1, competition: c
    s2 = FactoryBot.create :subscription, user: u2, competition: c
    FactoryBot.create :subscription, user: u3, competition: c

    r = t.ranks.find_by(user: u1)
    r.result = 1
    r.save

    r = t.ranks.find_by(user: u2)
    r.result = 2
    r.save

    r = t.ranks.find_by(user: u3)
    r.result = 3
    r.save

    expect(s2.result).to eq(2)
  end
end
