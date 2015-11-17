FactoryGirl.define do
  factory :badge do
    identification  "Merit"
    picture         "https://unsplash.it/100/100"
    description     Faker::Company.catch_phrase
  end

end
