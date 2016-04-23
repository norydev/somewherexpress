# == Schema Information
#
# Table name: subscriptions
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  competition_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :string           default("pending"), not null
#

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
      UserMailer.as_user_new_subscription(current_user.id, @competition.id).deliver_later
      UserMailer.as_author_new_subscription(current_user.id, @competition.id, @competition.author.id).deliver_later

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
      unless @subscription.status == "pending"
        UserMailer.as_user_subscription_status_changed(@subscription.user.id,
                                                       @subscription.competition.id,
                                                       @subscription.status).deliver_later
      end

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

    UserMailer.as_author_cancelation(@subscription.user.id,
                                     competition.id,
                                     competition.author.id).deliver_later
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
