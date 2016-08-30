# frozen_string_literal: true
# == Schema Information
#
# Table name: tracks
#
#  id             :integer          not null, primary key
#  competition_id :integer
#  start_time     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class TracksController < ApplicationController
  before_action :set_track, only: [:edit, :update, :destroy]

  def edit
    authorize @track, :update?

    @competition = @track.competition
    @form = Track::Form.new(@track)
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
