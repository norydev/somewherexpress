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

class NotificationSettingsController < ApplicationController
  before_action :set_notification_setting, only: [:update]

  def update
    authorize @notifications

    if @notifications.update(notifications_params)
      redirect_to edit_user_registration_path(@notifications.user)
    else
      render edit_user_registration_path(@notifications.user)
    end
  end

  private

    def set_notification_setting
      @notifications = NotificationSetting.find(params[:id])
    end

    def notifications_params
      params.require(:notification_setting).permit(:as_user_new_competition,
        :as_user_competition_edited, :as_user_new_subscription,
        :as_user_subscription_status_changed, :as_author_new_subscription,
        :as_author_cancelation, :locale)
    end
end
