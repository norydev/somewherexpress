# frozen_string_literal: true
# == Schema Information
#
# Table name: tracks
#
#  id             :integer          not null, primary key
#  competition_id :integer
#  start_time     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  start_city_id  :integer
#  end_city_id    :integer
#

FactoryGirl.define do
  factory :track do
    association     :competition
    start_time      DateTime.parse("10 april 2015 14:00").in_time_zone
  end
end
