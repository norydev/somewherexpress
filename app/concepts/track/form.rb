# frozen_string_literal: true
class Track < ActiveRecord::Base
  class Form < Reform::Form
    include ActiveModel::ModelReflections
    model :track

    collection :ranks do
      property :points
      property :result
      property :dsq

      property :user
    end

    def to_s
      model.to_s
    end
  end
end
