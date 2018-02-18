# frozen_string_literal: true
# == Schema Information
#
# Table name: ranks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  result     :integer          default(0)
#  points     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  race_id    :integer
#  race_type  :string
#  dsq        :boolean          default(FALSE), not null
#
# Indexes
#
#  index_ranks_on_race_type_and_race_id  (race_type,race_id)
#  index_ranks_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :rank do
    association   :user
    association   :race
    result        1
    points        5
  end
end
