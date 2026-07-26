Rails.application.routes.draw do
  root "homes#top"
  get "home/about", as: "about", to: "homes#about"

  resource :session
  resources :passwords, param: :token

  get "users/sign_up", to: "users#new", as: "new_user"
  resources :users, except: [:new]

  resources :books
end
