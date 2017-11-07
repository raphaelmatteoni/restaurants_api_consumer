class RestaurantsController < ApplicationController
	require 'rest_client'

	API_BASE_URL = "http://localhost:3000/api/v1"

	def index
		if params[:by_name].present?
			uri = "#{API_BASE_URL}/restaurants?by_name=#{params[:by_name]}"
		else
			uri = "#{API_BASE_URL}/restaurants.json"
		end
		rest_resource = RestClient::Resource.new(uri)
		restaurants = rest_resource.get
		@restaurants = JSON.parse(restaurants, symbolize_names: true)
	end

	def show
    uri = "#{API_BASE_URL}/restaurants/#{params[:id]}.json"
    rest_resource = RestClient::Resource.new(uri)
    restaurants = rest_resource.get
    @restaurant = JSON.parse(restaurants, :symbolize_names => true)
	end

	def new
		
	end

	def create
   uri = "#{API_BASE_URL}/restaurants"
    payload = params.to_json
    rest_resource = RestClient::Resource.new(uri)
    begin
      rest_resource.post payload , :content_type => "application/json"
      flash[:notice] = "Restaurant Saved successfully"
      redirect_to restaurants_path
    rescue Exception => e
     flash[:error] = "Restaurant Failed to save"
     render :new
    end
	end

	def edit
    uri = "#{API_BASE_URL}/restaurants/#{params[:id]}.json"
    rest_resource = RestClient::Resource.new(uri)
    restaurants = rest_resource.get
    @restaurant = JSON.parse(restaurants, :symbolize_names => true)
	end

	def update
    uri = "#{API_BASE_URL}/restaurants/#{params[:id]}"
    payload = params.to_json
    rest_resource = RestClient::Resource.new(uri)
    begin
      rest_resource.put payload , :content_type => "application/json"
      flash[:notice] = "Restaurant Updated successfully"
    rescue Exception => e
      flash[:error] = "Restaurant Failed to Update"
    end
    redirect_to restaurants_path
	end

	def destroy
    uri = "#{API_BASE_URL}/restaurants/#{params[:id]}"
    rest_resource = RestClient::Resource.new(uri)
    begin
     rest_resource.delete
     flash[:notice] = "Restaurant Deleted successfully"
    rescue Exception => e
     flash[:error] = "Restaurant Failed to Delete"
    end
    redirect_to restaurants_path
 	end
end
