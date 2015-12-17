Rails.application.routes.draw do
  root to: 'pages#index'

  ActiveAdmin.routes(self)
  devise_for :users

  resources :flows, only: [:index, :show, :new, :create, :edit, :update]
  resources :preferences, only:[:new, :create, :edit, :update]


end
