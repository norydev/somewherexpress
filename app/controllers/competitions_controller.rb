class CompetitionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_competition, only: [:show, :edit, :update, :destroy]

  def index
    @competitions = policy_scope(Competition)
  end

  def show
    authorize @competition
  end

  def new
    @competition = current_user.creations.new
    authorize @competition, :create?

    @competition.build_start_city
    @competition.build_end_city

    @competition.tracks.build
    @competition.tracks.last.build_start_city
    @competition.tracks.last.build_end_city
  end

  def edit
    authorize @competition, :update?

    @tracks = @competition.tracks.order(:start_time, :created_at)
    track = @competition.tracks.build
    track.build_start_city
    track.build_end_city
    @tracks << track
  end

  def create
    @competition = current_user.creations.new(competition_params)
    authorize @competition

    if @competition.save
      redirect_to @competition, notice: 'Competition was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @competition

    if @competition.update(competition_params)
      redirect_to @competition, notice: 'Competition was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @competition

    @competition.destroy
    redirect_to competitions_path, notice: 'Competition was successfully deleted.'
  end

  private
    def set_competition
      @competition = Competition.find(params[:id])
    end

    def competition_params
      params.require(:competition).permit(
        :name, :start_date, :end_date, :start_registration,
        :end_registration, :published, :finished, :description, :default_registration_status, :video,
        start_city_attributes: [:id, :name, :street_number, :route, :locality, :administrative_area_level_2,
          :administrative_area_level_1, :administrative_area_level_1_short, :country,
          :country_short, :postal_code],
        end_city_attributes: [:id, :name, :street_number, :route, :locality, :administrative_area_level_2,
          :administrative_area_level_1, :administrative_area_level_1_short, :country,
          :country_short, :postal_code],
        tracks_attributes: [:id, :start_time,
          start_city_attributes: [:id, :name, :street_number, :route, :locality, :administrative_area_level_2,
          :administrative_area_level_1, :administrative_area_level_1_short, :country,
          :country_short, :postal_code],
          end_city_attributes: [:id, :name, :street_number, :route, :locality, :administrative_area_level_2,
          :administrative_area_level_1, :administrative_area_level_1_short, :country,
          :country_short, :postal_code]]
        )
    end
end
