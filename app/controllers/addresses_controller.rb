class AddressesController < ApplicationController

  def index
    addresses = Address.all
    render json: addresses.to_json, status: 200
  end

  def new
    address = Address.new
    render json: address.to_json, status: 200
  end

  def show
    if Address.exists?(params[:id])
      address = Address.find(params[:id])
      render json: address.to_json, status: 200
    else
      render json: { error_message: "The record id: #{params[:id]} not found!" }.to_json, status: 400
    end
  end

  def create
    if params[:user_id].nil? || params[:user_id].empty?
      error_message = "The 'user_id' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    elsif params[:street].nil? || params[:street].empty?
      error_message = "The 'street' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    elsif params[:city].nil? || params[:city].empty?
      error_message = "The 'city' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    elsif params[:state].nil? || params[:state].empty?
      error_message = "The 'state' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    elsif params[:zip].nil? || params[:zip].empty?
      error_message = "The 'zip' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    else
      address = Address.new
      address.user_id = params[:user_id]
      address.street = params[:street]
      address.city = params[:city]
      address.state = params[:state]
      address.zip = params[:zip]
      address.save
      render json: address.to_json, status: 201
    end
  end

  def update
    if Address.exists?(params[:id])
      address = Address.find(params[:id])
      address.street = params[:street] unless params[:street].nil? || params[:street].empty?
      address.city = params[:city] unless params[:city].nil? || params[:city].empty?
      address.state = params[:state] unless params[:state].nil? || params[:state].empty?
      address.zip = params[:zip] unless params[:zip].nil? || params[:zip].empty?
      address.save
      render json: address.to_json, status: 200
    else
      render json: { error_message: "The record id: #{params[:id]} not found!" }.to_json, status: 400
    end
  end

  def destroy
    if Address.exists?(params[:id])
      address = Address.find(params[:id])
      address.destroy
      render json: { message: "Item with id: #{params[:id]} deleted successfully." }.to_json, status: 200
    else
      render json: { error_message: "Address id: #{params[:id]} not found!" }.to_json, status: 404
    end
  end
end



































