# frozen_string_literal: true
class Track < ActiveRecord::Base
  module Contract
    class Update < Reform::Form
      include ActiveModel::ModelReflections
      model :track

      collection :ranks do
        property :points
        property :result
        property :dsq

        delegate :user, to: :model
      end

      delegate :to_s, to: :model
    end
  end
end
