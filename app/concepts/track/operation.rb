# frozen_string_literal: true
class Track < ApplicationRecord
  class Update < Trailblazer::Operation
    include Model
    model Track, :update

    contract Contract::Update

    def process(params)
      validate(params[:track], &:save)
    end
  end
end
