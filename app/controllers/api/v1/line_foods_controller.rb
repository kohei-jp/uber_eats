module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create replace]

      def index
        line_foods = LineFood.active.all
        if line_foods.exists?
            line_food_ids = []
            count = 0
            amount = 0
          
            line_foods.each do |line_food|
              line_food_ids << line_food.id # (1) idを参照して配列に追加する
              count += line_food[:count] # (2)countのデータを合算する
              amount += line_food.total_amount # (3)total_amountを合算する
            end
          
            render json: {
              line_food_ids: line_food_ids,
              restaurant: line_foods[0].restaurant,
              count: count,
              amount: amount,
            }, status: :ok
          else
          render json: {}, status: :no_content

          # リファクタリング前(sumとmapを同じ変数に対して3回も行っている)
          # render json: {
          #   line_food_ids: line_foods.map{ |line_food| line_food.id },
          #   restaurant: line_foods[0].restaurant,
          #   count: line_foods.sum{ |line_food| line_food[:count] },
          #   amount: line_foods.sum{ |line_food| line_food.total_amount },
          #   }, status: :ok
        end
      end

      def create
        # 仮注文データに他の店舗の商品が存在するか?
        if LineFood.active.other_restaurant(@ordered_food.restaurant.id).exists?
          return render json: {
            # その店名
            existing_restaurant: LineFood.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name,
            # 追加しようとしている店名
            new_restaurant: Food.find(params[:food_id]).restaurant.name,
          },
          status: :not_acceptable
        end

        # 商品の追加
        set_line_food(@ordered_food)

        # 追加した商品の保存
        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {}, status: :internal_server_eroor
        end
      end

      def replace
        # 選択商品と異なる店舗の仮注文を論理削除する
        LineFood.active.other_restaurant(@ordered_food.restaurant.id).each do |line_food|
          line_food.update_attribute(:active, false)
        end

        set_line_food(@ordered_food)

        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end

      private
      def set_food
        @ordered_food = Food.find(params[:food_id])
      end

      # line_foodのインスタンスの作成
      def set_line_food(ordered_food)
        # 選択したfoodが現在line_foodに存在すれば
        if ordered_food.line_food.present?
          @line_food = ordered_food.line_food
          @line_food.attributes = {
            # 現在のcountに加算する
            count: ordered_food.line_food.count + params[:count],
            active: true # 現状の仮注文が入っている状態
          }
        else
          # 新規でline_foodを作成
          @line_food = ordered_food.build_line_food(
            count: params[:count],
            restaurant: ordered_food.restaurant,
            active: true
          )
        end
      end      
    end
  end
end
