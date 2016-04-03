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

FactoryGirl.define do
  factory :badge do
    identification  "Merit"
    picture         "https://unsplash.it/100/100"
    description     Faker::Company.catch_phrase
  end

end
