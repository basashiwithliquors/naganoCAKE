Rails.application.routes.draw do

  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/update'
  end
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

root 'public/homes#top'

namespace :admin do
  root 'homes#top'
  resources :orders, only: [:show, :update] do
    resources :order_items, only: [:update]
  end
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items, except: [:destroy]
  resources :customers, only: [:index, :show, :edit, :update]
end


namespace :public do
  get 'about' => "homes#about", as: 'about'
  resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
  resources :cart_items, only:[:index, :update, :destroy, :create]
  resources :items, only: [:index, :show]

  # resource :customers, only: [:show, :edit, :update]
  get "customers/mypage" => "customers#show"
  get "customers/information/edit" => "customers#edit"
  patch "customers/information" => "customers#update"

  get "customers/unsubscribe" => "customers#unsubscribe"
  patch "customers/withdraw" => "customers#withdraw"
end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
