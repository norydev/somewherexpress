# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Subscription.destroy_all
Competition.destroy_all
Track.destroy_all
Rank.destroy_all

10.times do
  u = User.new
  u.email = "#{Faker::Internet.user_name}@yopmail.com"
  u.password = "12345678"
  u.first_name = Faker::Name.first_name
  u.last_name = Faker::Name.last_name
  u.save
end

5.times do
  c = Competition.new
  c.name = "#{Faker::Address.city} #{Faker::Number.between(12, 15)}"
  c.start_date = Faker::Date.backward(1000)
  # c.end_date = c.start_date + rand(2..15)
  c.start_location = Faker::Address.city
  c.end_location = Faker::Address.city
  c.save
end

Competition.all.each do |c|
  User.all.each do |u|
    s = Subscription.new
    s.user = u
    s.competition = c
    s.save
  end

  if [true,false].sample
    t = Track.new
    t.competition = c
    t.start_time = DateTime.parse("#{c.start_date} 14:00")
    t.start_location = c.start_location
    t.end_location = c.end_location
    t.save

    c.end_date = c.start_date + 3
    c.save
  else
    stops = [Faker::Address.city, Faker::Address.city, Faker::Address.city]
    t = Track.new
    t.competition = c
    t.start_time = DateTime.parse("#{c.start_date} 14:00")
    t.start_location = c.start_location
    t.end_location = stops[0]
    t.save
    t = Track.new
    t.competition = c
    t.start_time = DateTime.parse("#{c.start_date + 2} 8:00")
    t.start_location = stops[0]
    t.end_location = stops[1]
    t.save
    t = Track.new
    t.competition = c
    t.start_time = DateTime.parse("#{c.start_date + 4} 14:00")
    t.start_location = stops[1]
    t.end_location = stops[2]
    t.save
    t = Track.new
    t.competition = c
    t.start_time = DateTime.parse("#{c.start_date + 6} 14:00")
    t.start_location = stops[2]
    t.end_location = c.end_location
    t.save

    c.end_date = c.start_date + 8
    c.save
  end
end

Track.all.each do |t|
  t.competition.users.shuffle.each_slice(2).to_a.each_with_index do |team, index|
    r = Rank.new
    r.track = t
    r.user = team[0]
    r.result = index + 1
    r.points = 5 - index
    r.save
    r = Rank.new
    r.track = t
    r.user = team[1]
    r.result = index + 1
    r.points = 5 - index
    r.save
  end
end
