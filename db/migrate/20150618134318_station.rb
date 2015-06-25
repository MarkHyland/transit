class CreateStationTable < ActiveRecord::Migration
  def change
  	create_table "wmataStation" do |t|
  		t.integer "sId"
  		t.string "stationName"
  		t.boolean "sLat"
  		t.boolean "sLong"
  		t.string "colorOne"
  		t.string "colorTwo"
  		t.string "colorThree"
  end
end
