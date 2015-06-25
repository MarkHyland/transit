require 'httparty'
require 'json'
require 'haversine'

class BikeshareAPI
	# Token = File.read "./token"

	include HTTParty
	base_uri 'http://www.capitalbikeshare.com/data/stations/bikeStations.xml'

	def initialize
	end

	def get_bike
		BikeshareAPI.get("")
	end


	# def user_location latitude, longitude
	# 	Array.new(2).push(latitude, longitude)  
	# end


	def nearest_station latitude, longitude
		get_bike["stations"]["station"].min_by(3) { |s| Haversine.distance([latitude.to_f, longitude.to_f],[s["lat"].to_f,s["long"].to_f]).to_miles }
	end
end

# spot = BikeshareAPI.new
# bike_info = spot.get_bike
# user_location = [38.9059620,-77.0423670]
# nearest_station = bike_info["stations"]["station"].min_by { |s| Haversine.distance(user_location,[s["lat"].to_f,s["long"].to_f]).to_miles }





