Rails.application.routes.draw do
  get '/' => "home#index"
  resources :orders
  resources :categories
  resources :items
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
