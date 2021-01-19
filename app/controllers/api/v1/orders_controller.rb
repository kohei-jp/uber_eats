module Api
  module V1
    class OrdersController < Api::V1::ApiController
      def create
        # binding.pry
        posted_line_foods = LineFood.where(id: params[:line_food_ids])
        # 仮注文をorderに紐づける
        order = Order.new(
          restaurant_id: posted_line_foods.first.restaurant_id,
          total_price: total_price(posted_line_foods),
        )
        if order.save_with_update_line_foods!(posted_line_foods)
          render json: {}, status: :no_content
        else
          render json: {}, status: :internal_server_eroor
        end
      end

      private
      def total_price(posted_line_foods)
        posted_line_foods.sum{|line_food| line_food.total_amount} + posted_line_foods.first.restaurant.fee
      end
    end
  end
end