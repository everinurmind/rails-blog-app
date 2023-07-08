Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users, path: 'auth',
                     path_names: { sign_in: 'login', password: 'secret', sign_up: 'register' }
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy', as: :logout
  end
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  resources :users do
    resources :posts, only: [:index, :show, :create, :destroy] do
      resources :comments, only: [:index, :create, :destroy]
      resources :likes, only: [:index, :create]
    end
    delete '/', to: 'users#destroy', as: 'destroy'
  end
end