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

# ゲストログイン
  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update] do
      member do
        get 'customer', to: 'orders#order_customer', as: 'orders_customer'
      end
    end
    resources :customers, only: [:index, :show, :edit, :update]
    resources :order_details, only: [:update]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :sessions, only: [:new, :create, :destroy]

  end

  scope module: :public do
    root to: 'homes#top'
    get 'homes/about'
    post 'customers/confirm_withdraw' => 'customers#confirm_withdraw', as: 'confirm_withdraw'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    #resources :customers, only: [:index, :show, :edit, :create, :update, :destroy]
    resources :customers do
      resource :relationships, only: [:create, :destroy, :index]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    get 'newly_arrived' => 'illustrations#newly_arrived', as: 'newly_arrived'
    get 'tag_index' => 'illustrations#tag_index', as: 'tag_index'
    resources :illustrations, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
      resources :favorites, only: [:create, :destroy]
    end
    resources :post_comments, only: [:new, :index, :show, :create, :edit, :destroy, :update]
    resources :registrations, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]

  end

  get '/search', to: 'searches#search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
