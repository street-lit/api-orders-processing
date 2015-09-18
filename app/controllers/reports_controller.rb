class ReportsController < ApplicationController
  def top_five_purchased_items
    purchases = Order.joins(:item).order('count_all desc').limit(5).group(:item_id).count
    if purchases.nil? || purchases.empty?
      render json: { error_message: "No items found." }.to_json, status: 404
    else
      five_items = []
      purchases.each do |key, value|
        five_items.push(Item.find(key))
      end
      render json: five_items.to_json, status: 200
    end
  end
end
