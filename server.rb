
require 'sinatra/base'
require 'tilt/erubis'
require 'rack/cors'
require 'pry'
require './db/setup'
require './lib/all'

require './wmata_api'
require './bikeshare_api'


class TransitApp < Sinatra::Base
	enable :logging
	enable :method_override
	enable :sessions

	set :session_secret, (ENV["SESSION_SECRET"] || "development")
		
	use Rack::Cors do 
		allow do
			origins '*'
			resource '*', headers: :any, methods: :get
		end
	end

	before do
    	headers["Content-Type"] = "application/json"
  	end

	after do
		ActiveRecord::Base.connection.close
	end

	get "/" do
		a = "Add /bikeshare or /stationLocation or /trainRealTime to see json"
		a.to_json
	end

	get "/stationLocation" do
		spot = WmataAPI.new
		a = []
		b = a.push(spot.nearest_station(params[:latitude],params[:longitude]))
		b.to_json
	end

	get "/bikeshare" do
		spot = BikeshareAPI.new
		a = []
		b = a.push(spot.nearest_station(params[:latitude],params[:longitude]))
		b.to_json
	end

	get "/trainRealTime" do
		spot = WmataAPI.new
		a = []
		b = a.push(spot.get_real_time(params[:closestStation]))
		b.to_json
	end
end


TransitApp.run!


