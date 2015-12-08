class TracksController < ApplicationController
  before_action :set_track, only: [:edit, :update, :destroy]

  def edit
    authorize @track, :update?
  end

  def update
    authorize @track
    if @track.update(track_params)
      redirect_to @track.competition
    else
      render :edit
    end
  end

  def destroy
    authorize @track

    competition = @track.competition
    @track.destroy

    respond_to do |format|
      format.html { redirect_to competition }
      format.js
    end
  end

  private

    def set_track
      @track = Track.find(params[:id])
    end

    def track_params
      params.require(:track).permit(ranks_attributes: [:id, :points, :result, :dsq])
    end
end
