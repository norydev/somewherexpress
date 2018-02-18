# frozen_string_literal: true
# == Schema Information
#
# Table name: competitions
#
#  id                          :integer          not null, primary key
#  name                        :string
#  start_date                  :date
#  end_date                    :date
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  finished                    :boolean          default(FALSE), not null
#  published                   :boolean          default(FALSE), not null
#  start_registration          :datetime
#  end_registration            :datetime
#  author_id                   :integer
#  description                 :text
#  video                       :string
#  start_city_id               :integer
#  end_city_id                 :integer
#  default_registration_status :integer          default("pending"), not null
#
# Indexes
#
#  index_competitions_on_start_city_id_and_end_city_id  (start_city_id,end_city_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (end_city_id => cities.id)
#  fk_rails_...  (start_city_id => cities.id)
#

FactoryBot.define do
  factory :competition do
    name            "Paris express 15"
    start_date      Date.parse("10 april 2015")
    end_date        Date.parse("15 april 2015")
    finished        true
    published       false
    start_registration    "10 november 2014 00:00:00".in_time_zone
    end_registration      "1 april 2015 00:00:00".in_time_zone
    association           :author, factory: :user, email: "ramirez@yopmail.com"
    description           "This race is great"
    default_registration_status "accepted"
  end
end
