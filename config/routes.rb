Rails.application.routes.draw do
  root 'root#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :users, only: [:new, :create]
  resources :trips, only: [:index]

  get '/dashboard', to: 'dashboard#show'
end
