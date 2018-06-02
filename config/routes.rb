Rails.application.routes.draw do
  root 'root#index'
  resources :accessories, path: 'bike-shop', only: [:index, :show]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :carts, only: [:create, :index]
  resources :trips, only: [:index, :destroy]
  resources :stations, only: [:index]

  get '/cart', to: 'cart#index'

  resources :orders
  get '/dashboard', to: 'dashboard#show'
  resources :stations, param: :slug, only: [:show, :index]
  resources :trips
  namespace :admin do
    resources :accessories, path: '/bike-shop', only: [:new, :create]
    resources :trips
    resources :stations
    get '/dashboard', to: 'dashboard#show'
  end
end
