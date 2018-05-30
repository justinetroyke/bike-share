Rails.application.routes.draw do
  resources :accessories, path: 'bike-shop', only: [:index, :show]
  root 'root#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :carts, only: [:create]

  resources :trips, only: [:index]
  resources :orders
  get '/dashboard', to: 'dashboard#show'
  resources :stations, param: :slug, only: [:show, :index]
  resources :trips
  namespace :admin do
    resources :trips
    resources :stations
    get '/dashboard', to: 'dashboard#show'
  end
end
