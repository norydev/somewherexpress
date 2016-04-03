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

FactoryGirl.define do
  factory :subscription do
    association   :user
    association   :competition
    status        "accepted"
  end
end
