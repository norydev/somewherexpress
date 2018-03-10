# frozen_string_literal: true
class City < ApplicationRecord
  class Form < Reform::Form
    property :name
    property :locality
    property :country_short
    property :picture

    validates :name, :locality, :country_short, presence: true
  end
end
