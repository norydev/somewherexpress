class MoveCitiesToNewColumns < ActiveRecord::Migration
  def change
    Competition.where(start_registration: nil).each do |competition|
      competition.start_registration = competition.created_at
      competition.save
    end

    Competition.all.each do |competition|
      competition.start_city_id = City.order(:created_at).find_by(locality: competition.start_city.locality).id
      competition.end_city_id   = City.order(:created_at).find_by(locality: competition.end_city.locality).id
      competition.save
    end

    Track.all.each do |track|
      track.start_city_id = City.order(:created_at).find_by(locality: track.start_city.locality).id
      track.end_city_id   = City.order(:created_at).find_by(locality: track.end_city.locality).id
      track.save
    end
  end
end
