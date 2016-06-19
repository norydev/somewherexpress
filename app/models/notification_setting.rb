# frozen_string_literal: true
# == Schema Information
#
# Table name: notification_settings
#
#  id                                  :integer          not null, primary key
#  user_id                             :integer
#  as_user_new_competition             :boolean          default(TRUE), not null
#  as_user_competition_edited          :boolean          default(TRUE), not null
#  as_user_new_subscription            :boolean          default(TRUE), not null
#  as_user_subscription_status_changed :boolean          default(TRUE), not null
#  as_author_new_subscription          :boolean          default(TRUE), not null
#  as_author_cancelation               :boolean          default(TRUE), not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  locale                              :string           default("fr"), not null
#

class NotificationSetting < ActiveRecord::Base
  belongs_to :user
end
