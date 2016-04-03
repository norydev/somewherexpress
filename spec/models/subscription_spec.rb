# == Schema Information
#
# Table name: subscriptions
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  competition_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :string           default("pending"), not null
#

require 'rails_helper'

RSpec.describe Subscription, type: :model do

  it { should belong_to(:user) }
  it { should belong_to(:competition) }
  it { should validate_acceptance_of(:rules) }

  it 'returns the correct nb of points' do
    u = FactoryGirl.create :user, email: "u1@yopmail.com"
    c = FactoryGirl.create :competition, start_city: FactoryGirl.create(:city, order: "start", localizable: c), end_city: FactoryGirl.create(:city, order: "end", localizable: c)

    ts = []
    5.times do |n|
      ts[n] = FactoryGirl.create :track, competition: c, start_city: FactoryGirl.create(:city, order: "start", localizable: ts[n]), end_city: FactoryGirl.create(:city, order: "end", localizable: ts[n])
    end

    s = FactoryGirl.create :subscription, user: u, competition: c, rules: "1"

    ts.each do |t|
      r = t.ranks.find_by(user: u)
      r.points = 4
      r.save
    end

    expect(s.points).to eq(20)
  end

  it 'returns the correct result' do
    u1 = FactoryGirl.create :user, email: "u1@yopmail.com"
    u2 = FactoryGirl.create :user, email: "u2@yopmail.com"
    u3 = FactoryGirl.create :user, email: "u3@yopmail.com"
    c = FactoryGirl.create :competition, start_city: FactoryGirl.create(:city, order: "start", localizable: c), end_city: FactoryGirl.create(:city, order: "end", localizable: c)
    t = FactoryGirl.create :track, competition: c, start_city: FactoryGirl.create(:city, order: "start", localizable: c), end_city: FactoryGirl.create(:city, order: "end", localizable: c)
    FactoryGirl.create :subscription, user: u1, competition: c, rules: "1"
    s2 = FactoryGirl.create :subscription, user: u2, competition: c, rules: "1"
    FactoryGirl.create :subscription, user: u3, competition: c, rules: "1"

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
