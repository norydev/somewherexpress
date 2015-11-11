class SubscriptionsController < ApplicationController
  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user = current_user

    if @subscription.save
      redirect_to @subscription.competition, notice: 'Your application has been sent.'
    else
      redirect_to @subscription.competition, alert: (@subscription.errors[:user_id].join(', ') || 'Your application failed.')
    end
  end

  def destroy
  end

  private
    def subscription_params
      params.require(:subscription).permit(:competition_id)
    end
end
