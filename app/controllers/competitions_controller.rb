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
#  video                       :string
#  start_city_id               :integer
#  end_city_id                 :integer
#  default_registration_status :integer          default("pending"), not null
#
# Indexes
#
#  index_competitions_on_start_city_id_and_end_city_id  (start_city_id,end_city_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (end_city_id => cities.id)
#  fk_rails_...  (start_city_id => cities.id)
#

class CompetitionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_competition, only: [:show, :edit, :update, :destroy]

  def index
    @competitions = policy_scope(Competition)
                    .published
                    .most_recent_first
                    .preload(:start_city, :end_city, :accepted_users,
                             :pending_users, :refused_users,
                             tracks: [:start_city, :end_city],
                             subscriptions: :user)

    @markers = Marker.for_all_relevant_cities
  end

  def show
    authorize @competition

    @form = Competition::Contract::Update.new(@competition)
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

    @form = Competition::Contract::Create.new(Competition.new).prepopulate!
  end

  # This method is soon going to be deprecated, edit will be in show page
  def edit
    authorize @competition, :update?

    @form = Competition::Contract::Update.new(@competition)
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
