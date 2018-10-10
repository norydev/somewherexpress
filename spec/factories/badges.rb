# frozen_string_literal: true
# == Schema Information
#
# Table name: badges
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string
#  picture     :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_badges_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :badge do
    identification  { "Merit" }
    picture         { "https://unsplash.it/100/100" }
    description     { Faker::Company.catch_phrase }
  end
end
