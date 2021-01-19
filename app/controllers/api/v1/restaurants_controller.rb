module Api
  module V1
    class RestaurantsController < Api::V1::ApiController
      def index
        restaurants = Restaurant.all

        render json: {
          restaurants: restaurants
        }, status: :ok
      end
    end
  end
end