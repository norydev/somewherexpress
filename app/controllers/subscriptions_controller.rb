class SubscriptionsController < ApplicationController

  def new
    authorize Subscription.new
    redirect_to new_user_session_path, alert: t('devise.failure.unauthenticated')
  end

  def create
    @subscription = current_user.subscriptions.new(subscription_params)
    authorize @subscription

    if @subscription.save
      respond_to do |format|
        format.html { redirect_to @subscription.competition, notice: 'Your application has been sent.' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @subscription.competition, alert: 'Your application failed: rules must be accepted.' }
        format.js
      end
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
      params.require(:subscription).permit(:competition_id, :rules)
    end
end
