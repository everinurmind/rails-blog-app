Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users, path: 'auth',
                     path_names: { sign_in: 'login', password: 'secret', sign_up: 'register' }
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy', as: :logout
  end

  get '/users/:user_id/posts', to: 'posts#index', defaults: { format: 'json' }
  get '/users/:user_id/posts/:id/comments', to: 'comments#index', defaults: { format: 'json' }
  
  post '/users/:user_id/posts/:post_id/comments', to: 'comments#create', defaults: { format: 'json' }

  resources :users do
    resources :posts do
      resources :comments
      post 'likes', to: 'likes#create'
    end

    delete '/', to: 'users#destroy', as: 'destroy'
  end
end
