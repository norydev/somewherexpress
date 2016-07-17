namespace :cities do
  desc "fetch picture for existing cities"
  task fetch_picture: :environment do
    client = GooglePlaces::Client.new(ENV["GOOGLE_SERVER"])
    City.all.each do |city|
      begin
        spot = client.spots(city.lat, city.lng).first
        picture = spot.photos.first.fetch_url(1200)
        city.update!(picture: picture)
        p "new city picture: #{city.picture}"
      rescue
      end
    end
  end
end
