Rails.application.routes.draw do
  namespace :admin do
    resources :orders, only: [:show, :update] do
      resources :order_items, only: [:update]
    end
  end

  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
