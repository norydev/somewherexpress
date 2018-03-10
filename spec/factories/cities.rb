# frozen_string_literal: true
# == Schema Information
#
# Table name: cities
#
#  id            :integer          not null, primary key
#  name          :string
#  locality      :string
#  country_short :string
#  lat           :float
#  lng           :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  picture       :string
#

FactoryBot.define do
  factory :city do
    name          "Yverdon-les-Bains, Suisse"
    lat           46.7784736
    lng           6.641183
    locality      "Yverdon-les-Bains"
    country_short "CH"
  end
end
