class ItemsController < ApplicationController

  def index
    items = Item.all
    render json: items.to_json, status: 200
  end

  def new
    item = Item.new
    render json: item.to_json, status: 200
  end

  def show
    if Item.exists?(params[:id])
      item = Item.find(params[:id])
      render json: item.to_json, status: 200
    else
      render json: { error_message: "The record id: #{params[:id]} wasn't found!" }.to_json, status: 404
    end
  end

  def create
    if params[:name].nil? || params[:name].empty?
      error_message = "The 'name' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    elsif params[:price].nil? || params[:price].empty?
      error_message = "The 'price' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    elsif params[:description].nil? || params[:description].empty?
      error_message = "The 'description' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    else
      item = Item.new
      item.name = params[:name]
      item.price = params[:price]
      item.description = params[:description]
      item.save
      render json: item.to_json, status: 201
    end
  end

  def update
    if Item.exists?(params[:id])
      item = Item.find(params[:id])
      item.name = params[:name] unless params[:name].nil? || params[:name].empty?
      item.price = params[:price] unless params[:price].nil? || params[:price].empty?
      item.description = params[:description] unless params[:description].nil? || params[:description].empty?
      item.save
      render json: item.to_json, status: 200
    else
      render json: { error_message: "The record id: #{params[:id]} wasn't found!" }.to_json, status: 404
    end
  end

  def destroy
    if Item.exists?(params[:id])
      item = Item.find(params[:id])
      item.destroy
      render json: { message: "User with id: #{params[:id]} deleted successfully." }.to_json, status: 200
    else
      render json: { error_message: "The record id: #{params[:id]} wasn't found!" }.to_json, status: 404
    end
  end
end

































