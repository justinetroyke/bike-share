Rails.application.routes.draw do
  resources :accessories, path: 'bike-shop', only: [:index]
  root 'root#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :carts, only: [:create]

  resources :trips, only: [:index]

  get '/dashboard', to: 'dashboard#show'
  resources :stations, param: :slug, only: [:show]
  resources :trips
  namespace :admin do
    resources :trips
    get '/dashboard', to: 'dashboard#show'
  end
end
