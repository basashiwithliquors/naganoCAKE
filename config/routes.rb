Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

# root to: "public/homes#top"
# top
root 'public/homes#top'
# about
# get 'about' => 'public/homes#about'


namespace :admin do
  root 'homes#top'
  resources :orders, only: [:show, :update] do
    resources :order_items, only: [:update]
  end
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items, except: [:destroy]
  resources :customers, only: [:index, :show, :edit, :update]
end

scope module: :public do
  get 'about' => "homes#about", as: 'about'

  resources :cart_items, only:[:index, :update, :destroy, :create] do
    collection do
      delete 'destroy_all'
    end
  end


  resources :items, only: [:index, :show]
  get 'orders/complete', to: 'orders#complete', as: 'complete_order'
  resources :orders, only: [:new, :index, :create, :show]
  post 'orders/confirm(/:id)', to: 'orders#confirm', as: 'confirm_order'


  # resource :customers, only: [:show, :edit, :update]
  get "customers/mypage" => "customers#show"
  get "customers/information/edit" => "customers#edit"
  patch "customers/information" => "customers#update"

  get "customers/unsubscribe" => "customers#unsubscribe"
  patch "customers/withdraw" => "customers#withdraw"

  resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
end