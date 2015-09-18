class UsersController < ApplicationController

  def index
    users = User.all
    render json: users.to_json, status: 200
  end

  def new
    user = User.new
    render json: user.to_json, status: 200
  end

  def show
    if User.exists?(params[:id])
      user = User.find(params[:id])
      render json: user.to_json, status: 200
    else
      render json: { error_message: "The record id: #{params[:id]} not found!" }.to_json, status: 404
    end
  end

  def create
    if params[:first_name].nil? || params[:first_name].empty?
      error_message = "The 'first_name' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    elsif params[:last_name].nil? || params[:last_name].empty?
      error_message = "The 'last_name' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    elsif params[:age].nil? || params[:age].empty?
      error_message = "The 'age' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    else
      user = User.new
      user.first_name = params[:first_name]
      user.last_name = params[:last_name]
      user.age = params[:age]
      user.save
      render json: user.to_json, status: 201
    end
  end

  def update
    if User.exists?(params[:id])
      user = User.find(params[:id])
      user.first_name = params[:first_name] unless params[:first_name].nil? || params[:first_name].empty?
      user.last_name = params[:last_name] unless params[:last_name].nil? || params[:last_name].empty?
      user.age = params[:age] unless params[:age].nil? || params[:age].empty?
      user.save
      render json: user.to_json, status: 200
    else
      render json: { error_message: "The record id: #{params[:id]} not found!" }.to_json, status: 404
    end
  end

  def destroy
    if User.exists?(params[:id])
      user = User.find(params[:id])
      user.destroy
      render json: { message: "User with id: #{params[:id]} deleted successfully." }.to_json, status: 200
    else
      render json: { error_message: "User id: #{params[:id]} not found!" }.to_json, status: 404
    end
  end

  def find_items_by_user
    items_by_user = User.find(params[:id]).items
    if items_by_user.nil? || items_by_user.empty?
      render json: { error_message: "User id: #{params[:id]} ordered no items!" }.to_json, status: 404
    else
      render json: items_by_user.to_json, status: 200
    end
  end
end


































