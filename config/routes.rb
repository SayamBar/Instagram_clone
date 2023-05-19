Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users
  resources :users
  resources :posts do
    resources :comments
  end

    
  # end
  resources :posts do
    resources :likes
  end

  resources :comments do
    resources :likes
  end

  namespace :api do
    namespace :v1 do
      resources :posts
      get '/postsofcurrentuser', to: 'posts#postsofcurrentuser'
      get '/likes/:post_id', to: 'posts#likescount'
      get '/comments/:post_id', to: 'posts#showcomments'
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "posts#index"
end
