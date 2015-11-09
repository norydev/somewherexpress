class CompetitionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_competition, only: [:show, :edit, :update]

  def show
  end

  def new
    @competition = Competition.new
    @competition.tracks.build
  end

  def edit
    @competition.tracks.build
  end

  def create
    @competition = Competition.new(competition_params)

    if @competition.save
      redirect_to @competition, notice: 'Competition was successfully created.'
    else
      render :new
    end
  end

  def update
    if @competition.update(competition_params)
      redirect_to @competition, notice: 'Competition was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_competition
      @competition = Competition.find(params[:id])
    end

    def competition_params
      params.require(:competition).permit(:name, :start_date, :end_date, :start_location, :end_location, tracks_attributes: [:id, :start_location, :end_location, :start_time])
    end
end
