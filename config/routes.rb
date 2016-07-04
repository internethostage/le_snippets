Rails.application.routes.draw do
  root 'languages#index'
  resources :users, only: [:new, :create]
  resources :languages, only: [:index, :show]
end
