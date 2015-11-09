class TracksController < ApplicationController
  before_action :set_track, only: [:destroy]

  def destroy
    @track.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Period was successfully deleted.' }
      format.js
    end
  end

  private

    def set_track
      @track = Track.find(params[:id])
    end
end
