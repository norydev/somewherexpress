# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  picture                :string
#  admin                  :boolean          default(FALSE), not null
#  organizer              :boolean          default(FALSE), not null
#  deleted_at             :datetime
#  old_first_name         :string
#  old_last_name          :string
#  old_email              :string
#  use_gravatar           :boolean          default(FALSE), not null
#  phone_number           :string
#  whatsapp               :boolean          default(FALSE), not null
#  telegram               :boolean          default(FALSE), not null
#  signal                 :boolean          default(FALSE), not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require "rails_helper"

RSpec.describe User, type: :model do
  describe "scopes" do
    it "hall_of_fame" do
      expected_result = <<~SQL
        SELECT \"users\".* FROM \"users\" LEFT OUTER JOIN \"ranks\"
        ON \"ranks\".\"user_id\" = \"users\".\"id\" AND \"ranks\".\"result\" = 1
        AND \"ranks\".\"race_type\" = 'Competition' LEFT OUTER JOIN \"competitions\"
        ON \"competitions\".\"id\" = \"ranks\".\"race_id\"
        AND \"competitions\".\"finished\" = 't'
        LEFT OUTER JOIN \"ranks\" \"first_ranks_users_join\"
        ON \"first_ranks_users_join\".\"user_id\" = \"users\".\"id\"
        AND \"first_ranks_users_join\".\"result\" = 1
        AND \"first_ranks_users_join\".\"race_type\" = 'Track'
        LEFT OUTER JOIN \"tracks\"
        ON \"tracks\".\"id\" = \"first_ranks_users_join\".\"race_id\"
        LEFT OUTER JOIN \"badges\" ON \"badges\".\"user_id\" = \"users\".\"id\"
        WHERE (EXISTS(SELECT 1 FROM \"subscriptions\"
        WHERE (users.id = subscriptions.user_id)))
        GROUP BY users.id
        ORDER BY count(competitions) desc, count(tracks) desc, count(badges) desc
      SQL
                        .gsub(/\s/, " ").strip

      expect(User.hall_of_fame.to_sql).to eq expected_result
    end
  end
end
