Rails.application.routes.draw do
  devise_for :users
  # resources :users do
    resources :posts do
      resources :comments
    # end
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "home#index"
end
