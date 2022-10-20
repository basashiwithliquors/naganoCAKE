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
  resources :orders, only: [:show, :update] do
    resources :order_items, only: [:update]
  end
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items, except: [:destroy]
end


namespace :public do
  get 'about' => "homes#about", as: 'about'
  resources :cart_items, only:[:index, :update, :destroy, :create]
  resources :items, only: [:index, :show]

  resource :customers, only: [:show, :edit, :update]
  get "customers/mypage" => "customers#show"
  get "customers/information/edit" => "customers#edit"
  patch "customers/information" => "customers#update"
end

resources :orders, only: [:new, :index, :create, :show, :confirm]
post 'orders/confirm(/:id)', to: 'orders#confirm', as: 'confirm_order'

scope module: :public do
  resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
