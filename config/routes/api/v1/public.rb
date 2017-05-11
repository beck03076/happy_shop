HappyShop::Application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      scope module: :public do
        get :products_count, controller: :products
        resources :products
      end
    end
  end
end
