class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:update, :destroy]

  # POST
  def new
    @subscription = Subscription.new(subscription_params)
    authorize @subscription
  end

  def edit
    @subscription = Subscription.find_by(subscription_params)
    authorize @subscription, :update?
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

  def update
    authorize @subscription

    if @subscription.update(subscription_params)
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Application updated successfuly.' }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.js
      end
    end

  end

  def destroy
    authorize @subscription

    competition = @subscription.competition
    @subscription.destroy

    redirect_to competition, notice: 'Your registration has been cancelled.'
  end

  private
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def subscription_params
      params.require(:subscription).permit(:competition_id, :user_id, :status, :rules)
    end
end
