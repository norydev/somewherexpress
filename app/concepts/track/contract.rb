# frozen_string_literal: true
class Track < ActiveRecord::Base
  module Contract
    class Update < Reform::Form
      include ActiveModel::ModelReflections
      model :track

      collection :ranks, populate_if_empty: :populate_rank! do
        property :points
        property :result
        property :dsq

        def user
          model.user
        end
      end

      def to_s
        model.to_s
      end

      private

        def populate_rank!(options)
          Rank.new(options[:fragment])
        end
    end
  end
end
