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
# Indexes
#
#  index_tracks_on_competition_id                 (competition_id)
#  index_tracks_on_start_city_id_and_end_city_id  (start_city_id,end_city_id)
#
# Foreign Keys
#
#  fk_rails_...  (competition_id => competitions.id)
#  fk_rails_...  (end_city_id => cities.id)
#  fk_rails_...  (start_city_id => cities.id)
#

FactoryBot.define do
  factory :track do
    association     :competition
    start_time      "10 april 2015 14:00:00".in_time_zone
  end
end
