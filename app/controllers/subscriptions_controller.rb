class SubscriptionsController < ApplicationController

  # POST
  def new
    @subscription = Subscription.new(subscription_params)
    authorize @subscription
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
        format.html { render :new }
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
      params.require(:subscription).permit(:competition_id, :status, :rules)
    end
end
