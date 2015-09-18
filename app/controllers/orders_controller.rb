class OrdersController < ApplicationController

  def index
    orders = Order.all
    render json: orders.to_json, status: 200
  end

  def new
    order = Order.new
    render json: order.to_json, status: 200
  end

  def show
    if Order.exists?(params[:id])
      order = Order.find(params[:id])
      render json: order.to_json, status: 200
    else
      render json: { error_message: "The record id: #{params[:id]} wasn't found!"}.to_json, status: 404
    end
  end

  def create
    if params[:item_id].nil? || params[:item_id].empty?
      error_message = "The 'item_id' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    elsif params[:user_id].nil? || params[:user_id].empty?
      error_message = "The 'user_id' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    elsif params[:quantity].nil? || params[:quantity].empty?
      error_message = "The 'quantity' field was empty or not found"
      render json: { error_message: error_message }.to_json, status: 422
    else
      order = Order.new
      order.item_id = params[:item_id]
      order.user_id = params[:user_id]
      order.quantity = params[:quantity]
      order.save
      render json: order.to_json, status: 201
    end
  end

  def update
    if Order.exists?(params[:id])
      order = Order.find(params[:id])
      order.item_id = params[:item_id] unless params[:item_id].nil? || params[:item_id].empty?
      order.user_id = params[:user_id] unless params[:user_id].nil? || params[:user_id].empty?
      order.quantity = params[:quantity] unless params[:quantity].nil? || params[:quantity].empty?
      order.save
      render json: order.to_json, status: 200
    else
      render json: { error_message: "The record id: #{params[:id]} wasn't found!" }.to_json, status: 404
    end
  end

  def destroy
    if Order.exists?(params[:id])
      order = Order.find(params[:id])
      order.destroy
      render json: { message: "Order with id: #{params[:id]} deleted successfully." }.to_json, status: 200
    else
      render json: { error_message: "Order id: #{params[:id]} wasn't found!" }.to_json, status: 404
    end
  end
end
































