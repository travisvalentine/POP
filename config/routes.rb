POP::Application.routes.draw do
  root :to => "users#new"
  match "/logout" => "sessions#destroy", :as => "logout"
  match "/settings" => "settings#show", :as => 'settings'
  match "/login" => "sessions#new", :as => "login"

  resources :settings
  resources :users
  resources :profiles
  resource :session
  resources :sessions
  resources :issues
  resources :problems
  resources :solutions
  resources :password_resets
end
