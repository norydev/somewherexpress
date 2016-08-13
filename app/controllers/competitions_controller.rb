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

    @form = form Competition::Update

    # @tracks = @competition.tracks.order(:start_time, :created_at)
    # track = @competition.tracks.build
    # track.build_start_city
    # track.build_end_city
    # @tracks << track
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
    @form = form Competition::Create

    # @competition = current_user.creations.new
    # authorize @competition, :create?

    # @competition.build_start_city
    # @competition.build_end_city

    # @competition.tracks.build
    # @competition.tracks.last.build_start_city
    # @competition.tracks.last.build_end_city
    # @tracks = @competition.tracks
  end

  # This method is soon going to be deprecated, edit will be in show page
  def edit
    authorize @competition, :update?

    @form = form Competition::Update

    @tracks = @competition.tracks.order(:start_time, :created_at)
    track = @competition.tracks.build
    track.build_start_city
    track.build_end_city
    @tracks << track
  end

  def create
    authorize Competition
    operation = run Competition::Create, params: params.merge(current_user: current_user) do |op|
      return redirect_to op.model
    end

    @form = operation.contract
    render action: :new

    #############
    # @competition = current_user.creations.new
    # authorize @competition

    # updater = Competitions::Update.new(@competition, params).call
    # @competition = updater.competition
    # @tracks = updater.updated_tracks

    # if @competition.valid? && @tracks.map(&:valid?).all?
    #   send_new_competition_emails if @competition.published?

    #   redirect_to @competition
    # else
    #   track = Track.new(end_city: City.new, start_city: City.new)
    #   @tracks << track

    #   render :new
    # end
  end

  def update
    authorize @competition

    operation = run Competition::Update, params: params.merge(current_user: current_user) do |op|
      if op.model.just_published?
        send_new_competition_emails
      elsif op.model.published? && !op.model.finished? && op.model.enough_changes?
        send_competition_edited_emails
      end

      return redirect_to op.model
    end

    @form = operation.contract
    render action: :edit

    # updater = Competitions::Update.new(@competition, params).call
    # @competition = updater.competition
    # @tracks = updater.updated_tracks

    # if @competition.valid? && @tracks.map(&:valid?).all?
    #   if @competition.just_published?
    #     send_new_competition_emails
    #   elsif @competition.published? && !@competition.finished? && @competition.enough_changes?
    #     send_competition_edited_emails
    #   end

    #   redirect_to @competition
    # else
    #   track = Track.new(end_city: City.new, start_city: City.new)
    #   @tracks << track

    #   render :edit
    # end
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

    def send_new_competition_emails
      User.want_email_for_new_competition.each do |user|
        UserMailer.as_user_new_competition(user.id, @competition.id).deliver_later
      end
    end

    def send_competition_edited_emails
      User.want_email_for_competition_edited(@competition).each do |user|
        UserMailer.as_user_competition_edited(user.id, @competition.id).deliver_later
      end
    end
end
