class TracksController < ApplicationController
  before_action :set_track, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @track.update(track_params)
      redirect_to @track.competition, notice: 'Result was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    competition = @track.competition
    @track.destroy

    respond_to do |format|
      format.html { redirect_to competition, notice: 'Track was successfully deleted.' }
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
