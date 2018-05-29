Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'root#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :users, only: [:new, :create]

  get '/dashboard', to: 'dashboard#show'
  resources :trips
  get '/:station-name', to: 'stations#show', as: :station
end
