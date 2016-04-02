class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:edit, :update, :destroy]
  before_action :find_competition, only: [:new, :edit, :create, :update]

  # POST
  def new
    @subscription = Subscription.new(competition: @competition, status: @competition.default_registration_status)
    authorize @subscription
  end

  def edit
    authorize @subscription, :update?
  end

  def create
    @subscription = current_user.subscriptions.new(subscription_params)
    @subscription.competition = @competition
    authorize @subscription

    if @subscription.save
      # UserMailer.new_subscription(@subscription).deliver_now
      # UserMailer.new_to_my(@subscription).deliver_now

      respond_to do |format|
        format.html { redirect_to @subscription.competition, notice: t('subscriptions.create.notice') }
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
      # UserMailer.status_changed(@subscription).deliver_now

      respond_to do |format|
        format.html { redirect_to root_path }
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

    # UserMailer.cancelation(@subscription).deliver_now
    @subscription.destroy

    redirect_to competition, notice: t('subscriptions.destroy.notice')
  end

  private
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def find_competition
      @competition = Competition.find(params[:competition_id])
    end

    def subscription_params
      params.require(:subscription).permit(:status, :rules)
    end
end
