Rails.application.routes.draw do
  # namespace: path,controllerをgrouping. ﾃﾞｨﾚｸﾄﾘ階層を分けられる
  namespace :api do
    # 開発途中でAPIの仕様を大幅に変更する可能性に備えてv1。
    namespace :v1 do
      resources :restaurants do
        # per restaurants
        resources :foods, only: %i[index]
      end
      # temporary order
      resources :line_foods, only: %i[index create]
      # Respond to put requests
      put 'line_foods/replace', to: 'line_foods#replace'
      resources :orders, only: %i[create]
    end
  end
end

# note
=begin
1. 出力されたroutes一覧から、'order'が含まれる一行のみを出力する。|(パイプ)でコマンドを繋げられる。
$ rails routes | grep order
2. 
=end