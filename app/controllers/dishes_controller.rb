class DishesController < ApplicationController
	require 'rest_client'

	API_BASE_URL = "http://localhost:3000/api/v1"

	def index
		uri = "#{API_BASE_URL}/dishes.json"
		rest_resource = RestClient::Resource.new(uri)
		dishes = rest_resource.get
		@dishes = JSON.parse(dishes, symbolize_names: true)
	end

	def show
    uri = "#{API_BASE_URL}/dishes/#{params[:id]}.json"
    rest_resource = RestClient::Resource.new(uri)
    dishes = rest_resource.get
    @dish = JSON.parse(dishes, :symbolize_names => true)
	end

	def new
		uri = "#{API_BASE_URL}/restaurants.json"
		rest_resource = RestClient::Resource.new(uri)
		dishes = rest_resource.get
		@restaurants = JSON.parse(dishes, symbolize_names: true)
	end

	def create
   uri = "#{API_BASE_URL}/dishes"
    payload = params.to_json
    rest_resource = RestClient::Resource.new(uri)
    begin
      rest_resource.post payload , :content_type => "application/json"
      flash[:notice] = "Dish Saved successfully"
      redirect_to dishes_path
    rescue Exception => e
     flash[:error] = "Dish Failed to save"
     render :new
    end
	end

	def edit
    uri_restaurants = "#{API_BASE_URL}/restaurants.json"
    rest_resource = RestClient::Resource.new(uri_restaurants)
    restaurants = rest_resource.get
    @restaurants = JSON.parse(restaurants, symbolize_names: true)

    uri_dishes = "#{API_BASE_URL}/dishes/#{params[:id]}.json"
    rest_resource = RestClient::Resource.new(uri_dishes)
    dishes = rest_resource.get
    @dish = JSON.parse(dishes, :symbolize_names => true)
	end

	def update
    uri = "#{API_BASE_URL}/dishes/#{params[:id]}"
    payload = params.to_json
    rest_resource = RestClient::Resource.new(uri)
    begin
      rest_resource.put payload , :content_type => "application/json"
      flash[:notice] = "Dish Updated successfully"
    rescue Exception => e
      flash[:error] = "Dish Failed to Update"
    end
    redirect_to dishes_path
	end

	def destroy
    uri = "#{API_BASE_URL}/dishes/#{params[:id]}"
    rest_resource = RestClient::Resource.new(uri)
    begin
     rest_resource.delete
     flash[:notice] = "Dish Deleted successfully"
    rescue Exception => e
     flash[:error] = "Dish Failed to Delete"
    end
    redirect_to dishes_path
 	end
end
