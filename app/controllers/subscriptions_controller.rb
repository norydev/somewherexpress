# frozen_string_literal: true
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
    authorize Subscription

    form Subscription::Create, user: current_user
  end

  def edit
    authorize @subscription, :update?
  end

  def create
    authorize Subscription.new(competition: @competition)

    operation = run Subscription::Create,
                    params: params.merge(current_user: current_user) do |op|
      return respond_to do |format|
        @form = op.contract
        format.html { redirect_to op.model.competition, notice: t("subscriptions.create.notice") }
        format.js
      end
    end

    respond_to do |format|
      @form = operation.contract
      format.html { render :new }
      format.js
    end
  end

  def update
    authorize @subscription

    operation = run Subscription::Update do |op|
      return respond_to do |format|
        @subscription = op.model
        format.html { redirect_to root_path }
        format.js
      end
    end

    @subscription = operation.contract
    respond_to do |format|
      format.html { render :edit }
      format.js
    end
  end

  def destroy
    authorize @subscription

    competition = @subscription.competition

    if competition.author.notification_setting.as_author_cancelation
      UserMailer.as_author_cancelation(@subscription.user.id,
                                       competition.id,
                                       competition.author.id).deliver_later
    end

    @subscription.destroy

    redirect_to competition, notice: t("subscriptions.destroy.notice")
  end

  private

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def find_competition
      @competition = Competition.find(params[:competition_id])
    end

    def subscription_params
      params.require(:subscription).permit(:status, :rules, :phone_number, :whatsapp, :telegram, :signal)
    end
end
