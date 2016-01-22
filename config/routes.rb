Rails.application.routes.draw do
  root to: 'pages#index'

  ActiveAdmin.routes(self)
  devise_for :users

  resources :compagny do
    namespace :account do
      root to: "boards#index"
        resources :flows, only: [:index, :show, :new, :create, :edit, :update]
        resources :organizations, only: [:index, :show, :create, :edit, :update ]
      end
    end


end



