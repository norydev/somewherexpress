# frozen_string_literal: true
class City < ActiveRecord::Base
  class Form < Reform::Form
    property :name
    property :street_number
    property :route
    property :locality
    property :administrative_area_level_2
    property :administrative_area_level_1
    property :administrative_area_level_1_short
    property :country
    property :country_short
    property :postal_code
    property :picture

    validates :name, :locality, :country_short, presence: true
  end
end
