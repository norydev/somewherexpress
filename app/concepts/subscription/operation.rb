# frozen_string_literal: true
class Subscription < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model
    model Subscription, :create

    contract Contract::Create

    def process(params)
      validate(params[:subscription]) do |f|
        f.save
        if model.user.notification_setting.as_user_new_subscription
          UserMailer.as_user_new_subscription(model.user.id,
                                              model.competition.id).deliver_later
        end
        if model.competition.author.notification_setting.as_author_new_subscription
          UserMailer.as_author_new_subscription(model.user.id,
                                                model.competition.id,
                                                model.competition.author.id).deliver_later
        end
      end
    end

    private

      def setup_params!(params)
        if params[:current_user]
          params[:subscription][:user_id] = params[:current_user][:id]
          params[:subscription][:user][:id] = params[:current_user][:id]
        end

        return unless params[:competition_id]
        params[:subscription][:competition_id] = params[:competition_id]
      end
  end

  class Update < Trailblazer::Operation
    include Model
    model Subscription, :update

    contract Contract::Update

    def process(params)
      validate(params[:subscription]) do |f|
        f.save
        if model.status != "pending" &&
           model.user.notification_setting.as_user_subscription_status_changed
          UserMailer.as_user_subscription_status_changed(model.user.id,
                                                         model.competition.id,
                                                         model.status).deliver_later
        end
      end
    end
  end
end
