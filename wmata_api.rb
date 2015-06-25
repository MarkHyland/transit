require 'httparty'
require 'json'
require 'haversine'

class WmataAPI
	# Token = File.read "./token"

	include HTTParty
	base_uri 'https://api.wmata.com'

	def initialize
	end

	def get_station 
		WmataAPI.get("/Rail.svc/json/jStations?", query: {api_key:"e1118d2314c245409c8b01d592d7c54f"})
	end


	# def user_location latitude, longitude
	# 	Array.new(2).push(latitude, longitude)
	# end


	def nearest_station latitude, longitude
		get_station["Stations"].min_by { |s| Haversine.distance([latitude.to_f, longitude.to_f],[s["Lat"].to_f,s["Lon"].to_f]).to_miles }
	end

##########################################################################################################

	def get_real_time closestStation
		response = WmataAPI.get("/StationPrediction.svc/json/GetPrediction/#{closestStation}", query: {api_key:"e1118d2314c245409c8b01d592d7c54f"})
		response["Trains"].first(6)
	end
end

# require 'pry'
# # spot = WmataAPI.new
# # station_info = spot.get_station
# # user_location = [38.9059620,-77.0423670]
# # nearest_station = station_info["Stations"].min_by { |s| Haversine.distance(user_location,[s["Lat"].to_f,s["Lon"].to_f]).to_miles }

# spot = WmataAPI.new
# binding.pry


