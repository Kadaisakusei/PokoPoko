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
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :illustrations, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
      resources :favorites, only: [:create, :destroy]
    end
    resources :registrations, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
