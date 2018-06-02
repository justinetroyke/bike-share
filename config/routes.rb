Rails.application.routes.draw do
  root 'root#index'
  resources :accessories, path: 'bike-shop', only: [:index, :show]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  resources :users, only: [:new, :create]
  resources :carts, only: [:create]

  resources :stations, param: :slug, only: [:index, :show]

  resources :orders
  get '/dashboard', to: 'dashboard#show'
  resources :trips
  namespace :admin do
    resources :stations
    resources :accessories, path: '/bike-shop', only: [:new, :create, :index, :edit, :update]
    resources :trips
    resources :orders
    resources :stations
    get '/dashboard', to: 'dashboard#show'
  end
end
