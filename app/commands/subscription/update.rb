# frozen_string_literal: true
class Subscription < ApplicationRecord
  class Update < ApplicationCommand
    attr_reader :form, :model

    def call
      set_subscription

      authorize @subscription, :update?

      @form = Subscription::Contract::Update.new(@subscription)

      return unless @form.validate(params[:subscription])

      @form.save
      @model = @form.model
      send_emails(model)
    end

    private

      def set_subscription
        @subscription = Subscription.find(params[:id])
      end

      def send_emails(model)
        if !model.pending? &&
           model.user.notification_setting.as_user_subscription_status_changed
          UserMailer.as_user_subscription_status_changed(model.user.id,
                                                         model.competition.id,
                                                         model.status)
                    .deliver_later
        end
      end
  end
end
