Rails.application.routes.draw do
  resources :accessories, path: 'bike-shop', only: [:index]

  root 'root#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :carts, only: [:create]

  get '/dashboard', to: 'dashboard#show'

end
