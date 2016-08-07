# frozen_string_literal: true
class Competition < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model
    model Competition, :create

    contract Contract::Create

    def process(params)
      validate(params[:competition], &:save)
    end

    private

      def setup_model!(params)
        model.author = params[:current_user]
      end
  end
end
