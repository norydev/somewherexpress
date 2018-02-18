# frozen_string_literal: true
# == Schema Information
#
# Table name: subscriptions
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  competition_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :integer          default("pending"), not null
#
# Indexes
#
#  index_subscriptions_on_competition_id  (competition_id)
#  index_subscriptions_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (competition_id => competitions.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :subscription do
    association   :user
    association   :competition
    status        "accepted"
  end
end
