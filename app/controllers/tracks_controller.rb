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
#  start_city_id  :integer
#  end_city_id    :integer
#
# Indexes
#
#  index_tracks_on_competition_id                 (competition_id)
#  index_tracks_on_start_city_id_and_end_city_id  (start_city_id,end_city_id)
#
# Foreign Keys
#
#  fk_rails_...  (competition_id => competitions.id)
#  fk_rails_...  (end_city_id => cities.id)
#  fk_rails_...  (start_city_id => cities.id)
#

class TracksController < ApplicationController
  before_action :set_track, only: [:edit, :update, :destroy]

  def edit
    authorize @track, :update?

    @competition = @track.competition
    @form = Track::Contract::Update.new(@track)
  end

  def update
    authorize @track

    @form = Track::Contract::Update.new(@track)

    if @form.validate(params[:track])
      @form.save
      redirect_to @form.model.competition
    else
      render action: :edit
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
end
