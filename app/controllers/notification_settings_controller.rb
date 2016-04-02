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
        :as_user_subscription_satus_changed, :as_author_new_subscription,
        :as_author_cancelation)
    end
end
