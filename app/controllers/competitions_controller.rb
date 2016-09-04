# frozen_string_literal: true
# == Schema Information
#
# Table name: competitions
#
#  id                          :integer          not null, primary key
#  name                        :string
#  start_date                  :date
#  end_date                    :date
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  finished                    :boolean          default(FALSE), not null
#  published                   :boolean          default(FALSE), not null
#  start_registration          :datetime
#  end_registration            :datetime
#  author_id                   :integer
#  description                 :text
#  default_registration_status :string           default("pending"), not null
#  video                       :string
#

class CompetitionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_competition, only: [:show, :edit, :update, :destroy]

  def index
    @competitions = policy_scope(Competition)
  end

  def show
    authorize @competition

    form Competition::Update
  end

  def event
    @competition = Competition.find(params[:competition_id])
    authorize @competition, :will_participate?

    respond_to do |format|
      format.ics { render text: @competition.ical_event, layout: false }
    end
  end

  def new
    authorize Competition, :create?

    form Competition::Create
  end

  # This method is soon going to be deprecated, edit will be in show page
  def edit
    authorize @competition, :update?

    form Competition::Update
  end

  def create
    authorize Competition
    operation = run Competition::Create,
                    params: params.merge(current_user: current_user) do |op|
      return redirect_to op.model
    end

    @form = operation.contract
    render action: :new
  end

  def update
    authorize @competition

    operation = run Competition::Update,
                    params: params.merge(current_user: current_user) do |op|
      return redirect_to op.model
    end

    @form = operation.contract
    render action: :edit
  end

  def destroy
    authorize @competition

    @competition.destroy
    redirect_to competitions_path, notice: "Competition was successfully deleted."
  end

  private

    def set_competition
      @competition = Competition.find(params[:id])
    end
end
