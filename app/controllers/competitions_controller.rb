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

    @competition.tracks.build
  end

  def edit
    authorize @competition, :update?

    @tracks = @competition.tracks.order(:start_time, :created_at)
    @tracks << @competition.tracks.build
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
        :name, :start_date, :end_date, :start_location, :end_location, :start_registration,
        :end_registration, :published, :finished, :description, :default_registration_status, :video,
        :start_location_street_number, :start_location_route, :start_location_locality,
        :start_location_administrative_area_level_2, :start_location_administrative_area_level_1,
        :start_location_administrative_area_level_1_short, :start_location_country,
        :start_location_country_short, :start_location_postal_code,
        :end_location_street_number, :end_location_route, :end_location_locality,
        :end_location_administrative_area_level_2, :end_location_administrative_area_level_1,
        :end_location_administrative_area_level_1_short, :end_location_country,
        :end_location_country_short, :end_location_postal_code,
        tracks_attributes: [:id, :start_location, :end_location, :start_time, :start_location_street_number, :start_location_route, :start_location_locality,
        :start_location_administrative_area_level_2, :start_location_administrative_area_level_1,
        :start_location_administrative_area_level_1_short, :start_location_country,
        :start_location_country_short, :start_location_postal_code,
        :end_location_street_number, :end_location_route, :end_location_locality,
        :end_location_administrative_area_level_2, :end_location_administrative_area_level_1,
        :end_location_administrative_area_level_1_short, :end_location_country,
        :end_location_country_short, :end_location_postal_code])
    end
end
