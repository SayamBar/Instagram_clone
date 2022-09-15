Rails.application.routes.draw do
  devise_for :users
  # resources :users do
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

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "posts#index"
end
