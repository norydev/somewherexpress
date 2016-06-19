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
#  default_registration_status :string           default("pending"), not null
#  video                       :string
#

FactoryGirl.define do
  factory :competition do
    name            "Paris express 15"
    start_date      Date.parse("10 april 2015")
    end_date        Date.parse("15 april 2015")
    finished        true
    published       false
    start_registration    DateTime.parse("10 november 2014")
    end_registration      DateTime.parse("1 april 2015")
    association           :author, factory: :user, email: "ramirez@yopmail.com"
    description           "This race is great"
    default_registration_status "accepted"
  end
end
