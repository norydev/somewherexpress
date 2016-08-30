# frozen_string_literal: true
class Track < ActiveRecord::Base
  class Update < Trailblazer::Operation
    include Model
    model Track, :update

    contract Contract::Update

    def process(params)
      validate(params[:track]) do |f|
        f.save
      end
    end
  end
end
