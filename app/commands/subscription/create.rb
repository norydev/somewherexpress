# frozen_string_literal: true
class Subscription < ApplicationRecord
  class Create < ApplicationCommand
    attr_reader :form, :model

    def call
      subscription = Subscription.new(competition_id: params[:competition_id],
                                      user_id: current_user&.id)

      authorize subscription, :create?

      @form = Subscription::Contract::Create.new(subscription)

      return unless @form.validate(
        params[:subscription].merge(user_attributes: { id: current_user&.id })
      )

      @form.save
      @model = @form.model
      send_emails(model)
    end

    private

      def send_emails(model)
        if model.user.notification_setting.as_user_new_subscription
          UserMailer.as_user_new_subscription(model.user.id,
                                              model.competition.id)
                    .deliver_later
        end
        if model.competition.author.notification_setting
                .as_author_new_subscription
          UserMailer.as_author_new_subscription(model.user.id,
                                                model.competition.id,
                                                model.competition.author.id)
                    .deliver_later
        end
      end
  end
end
