Rails.application.routes.draw do
  use_doorkeeper
  namespace :v1 do
    resources :client_apps
    post "users/create", to: "users#create", as: "users_create"
    delete "users/:uuid", to: "users#destroy", as: "user_destroy"
    post "users/login", to: "users#login", as: "users_login"
    get "users/me", to: "users#me", as: "users_me"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
