Rails.application.routes.draw do
  root 'root#index'
  resources :accessories, path: 'bike-shop', only: [:index, :show]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  # resources :users, only: [:new, :create, :edit, :update]
  get '/users/new', to: 'users#new', as: :new_user
  post '/users', to: 'users#create'
  get '/users/:id/edit', to: 'users#edit', as: :edit_user
  patch '/users/:id', to: 'users#update', as: :user

  # resources :stations, param: :slug, only: [:index, :show]
  get '/stations', to: 'stations#index'
  get '/stations/:slug', param: :slug, to: 'stations#show', as: :station

  # resources :carts
  post '/carts', to: 'carts#create'
  get '/cart', to: 'carts#show'
  post '/cart/remove_item', to:'carts#destroy'
  post '/cart/increase_item_count', to:'carts#increase'
  post '/cart/decrease_item_count', to:'carts#decrease'
  post '/carts/checkout', to: 'carts#checkout'

  # resources :orders
  get '/orders/:id', to: 'orders#show', as: :order

  get '/dashboard', to: 'dashboard#show'

  scope module: 'stations' do
    get '/stations-dashboard', to: 'dashboard#index'
  end

  scope module: 'trips' do
    get '/trips-dashboard', to: 'dashboard#index'
  end

  # resources :trips
  get '/trips', to: 'trips#index'
  get '/trips/:id', to: 'trips#show', as: :trip
  delete '/trips/:id', to: 'trips#destroy'

  scope module: :admin do
    get '/admin/stations/new', to: 'stations#new', as: :new_admin_station
    post '/admin/stations', to: 'stations#create', as: :admin_stations
    get '/admin/stations/:id/edit', to: 'stations#edit', as: :edit_admin_station
    patch '/admin/stations/:id', to: 'stations#update', as: :admin_station
    delete '/admin/stations/:id', to: 'stations#destroy'

    get '/admin/bike-shop/new', to: 'accessories#new', as: :new_admin_accessory
    post '/admin/bike-shop', to: 'accessories#create', as: :admin_accessories
    get '/admin/bike-shop', to: 'accessories#index'
    get '/admin/bike-shop/:id/edit', to: 'accessories#edit', as: :edit_admin_accessory
    patch '/admin/bike-shop/:id', to: 'accessories#update', as: :admin_accessory

    get '/admin/trips/new', to: 'trips#new', as: :new_admin_trip
    post '/admin/trips', to: 'trips#create', as: :admin_trips
    get '/admin/trips/:id/edit', to: 'trips#edit', as: :edit_admin_trip
    patch '/admin/trips/:id', to: 'trips#update', as: :admin_trip
    delete '/admin/trips/:id', to: 'trips#destroy'

    patch '/admin/orders/:id', to: 'orders#update', as: :admin_order
  end

  namespace :admin do
    # resources :stations
    # resources :accessories, path: '/bike-shop', only: [:new, :create, :index, :edit, :update]
    # resources :trips
    # resources :orders
    get '/dashboard', to: 'dashboard#show'
  end
end
