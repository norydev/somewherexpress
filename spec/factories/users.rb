FactoryGirl.define do
  factory :user do
    email       Faker::Internet.email
    password    "12345678"
    first_name  Faker::Name.first_name
    last_name   Faker::Name.last_name
    picture     "https://unsplash.it/200/200"
    girl        false
    organizer   true
    admin       false
  end
end
