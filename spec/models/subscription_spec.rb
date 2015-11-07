require 'rails_helper'

RSpec.describe Subscription, type: :model do

  it { should belong_to(:user) }
  it { should belong_to(:competition) }

  it 'returns the correct nb of points' do
    u = FactoryGirl.create :user
    c = FactoryGirl.create :competition
    s = FactoryGirl.create :subscription, user: u, competition: c

    5.times do
      FactoryGirl.create :track, competition: c
    end
    Track.all.each do |t|
      FactoryGirl.create :rank, user: u, race: t, points: 4, result: 2
    end
    expect(s.points).to eq(20)
  end

  it 'returns the correct result' do
    u1 = FactoryGirl.create :user
    u2 = FactoryGirl.create :user, email: "u2@yopmail.com"
    u3 = FactoryGirl.create :user, email: "u3@yopmail.com"
    c = FactoryGirl.create :competition
    s = FactoryGirl.create :subscription, user: u2, competition: c

    t = FactoryGirl.create :track, competition: c

    FactoryGirl.create :rank, race: t, user: u1, points: 5, result: 1
    FactoryGirl.create :rank, race: t, user: u2, points: 4, result: 2
    FactoryGirl.create :rank, race: t, user: u3, points: 3, result: 3

    expect(s.result).to eq(2)
  end

end
