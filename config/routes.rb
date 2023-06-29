Rails.application.routes.draw do
  root 'users#index'

  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  get '/users/:user_id/posts', to: 'posts#index'
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'

  resources :users do
    resources :posts do
      resources :comments, only: [:create, :new]
      resources :likes, only: [:create]
    end

    delete '/', to: 'users#destroy', as: 'destroy'
  end
end
