# == Schema Information
#
# Table name: tracks
#
#  id             :integer          not null, primary key
#  competition_id :integer
#  start_time     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :track do
    association     :competition
    start_time      DateTime.parse("10 april 2015 14:00")
  end

end
