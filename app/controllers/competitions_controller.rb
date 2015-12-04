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

    @competition.start_city.build
    @competition.end_city.build
    @competition.tracks.build
    @competition.tracks.each do |t|
      t.start_city.build
      t.end_city.build
    end
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
        :name, :start_date, :end_date, :start_registration,
        :end_registration, :published, :finished, :description, :default_registration_status, :video,
        cities_attributes: [:id, :name, :street_number, :route, :locality, :administrative_area_level_2,
          :administrative_area_level_1, :administrative_area_level_1_short, :country,
          :country_short, :postal_code],
        tracks_attributes: [:id, :start_time, cities_attributes: [:id, :name, :street_number, :route, :locality, :administrative_area_level_2,
          :administrative_area_level_1, :administrative_area_level_1_short, :country,
          :country_short, :postal_code]])
    end
end
