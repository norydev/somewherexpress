FactoryGirl.define do
  factory :competition do
    name = "#{Faker::Address.city} #{Faker::Number.between(12, 15)}"
    start_date = Date.parse("10 april 2015")
    end_date = Date.parse("15 april 2015")
    start_location = "Yverdon-les-Bains"
    end_location = "Paris"
  end

end
