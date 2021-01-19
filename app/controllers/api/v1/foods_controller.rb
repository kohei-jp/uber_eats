module Api
  module V1
    class FoodsController < Api::V1::ApiController
      def index
        restaurant = Restaurant.find(params[:restaurant_id])
        foods = restaurant.foods

        render json: {
          foods: foods
        }, status: :ok
      end
    end
  end
end