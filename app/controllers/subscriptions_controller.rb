class SubscriptionsController < ApplicationController

  def create
    @subscription = current_user.subscriptions.new(subscription_params)
    authorize @subscription

    if @subscription.save
      redirect_to @subscription.competition, notice: 'Your application has been sent.'
    else
      redirect_to @subscription.competition, alert: (@subscription.errors[:user_id].join(', ') || 'Your application failed.')
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    authorize @subscription

    competition = @subscription.competition
    @subscription.destroy

    redirect_to competition, notice: 'Your registration has been cancelled.'
  end

  private
    def subscription_params
      params.require(:subscription).permit(:competition_id)
    end
end
