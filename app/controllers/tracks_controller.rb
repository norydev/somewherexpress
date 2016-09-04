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
    form Track::Update
  end

  def update
    authorize @track

    operation = run Track::Update do |op|
      return redirect_to op.model.competition
    end

    @form = operation.contract
    render action: :edit
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
end
