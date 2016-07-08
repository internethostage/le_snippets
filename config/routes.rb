Rails.application.routes.draw do
  root 'languages#index'
  resources :users, only: [:new, :create]
  resources :languages, only: [:index]
  resources :snippets, except: [:index]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
