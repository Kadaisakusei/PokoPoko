Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  get 'post_comments/new'
  get 'post_comments/show'
  get 'post_comments/edit'
  get 'post_comments/index'
  get 'illustrations/new'
  get 'illustrations/show'
  get 'illustrations/edit'
  get 'illustrations/index'
  get 'users/show'
  get 'users/edit'
  get 'users/index'
  get 'homes/top'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
