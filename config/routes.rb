Rails.application.routes.draw do
  root 'root#index'
  resources :accessories, path: 'bike-shop', only: [:index, :show]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  resources :users, only: [:new, :create]
  resources :stations, param: :slug, only: [:index, :show]

  resources :carts
  get '/cart', to: 'carts#show'
  resources :orders
  get '/dashboard', to: 'dashboard#show'
  scope module: 'stations' do
    get '/stations-dashboard', to: 'dashboard#index'
  end
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
