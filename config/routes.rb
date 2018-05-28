Rails.application.routes.draw do
  root 'root#index'
  resources :users, only: [:new, :create]
  resources :trips, only: [:index]

  get '/dashboard', to: 'dashboard#show'
end
