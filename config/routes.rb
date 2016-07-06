Rails.application.routes.draw do
  root 'static#index'
  resources :users, only: [:new, :create]
  resources :languages, only: [:index]
  resources :snippets
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
