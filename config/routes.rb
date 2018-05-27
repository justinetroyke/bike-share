Rails.application.routes.draw do
  root 'root#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  resources :users, only: [:new, :create]
  resources :trips, only: [:index]

  get '/dashboard', to: 'dashboard#show'
end
