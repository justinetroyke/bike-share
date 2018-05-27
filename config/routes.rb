Rails.application.routes.draw do
  resources :accessories, path: 'bike-shop', only: [:index]
end
