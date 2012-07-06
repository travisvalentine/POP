POP::Application.routes.draw do
  
  require 'resque/server'
  mount Resque::Server.new, :at => "/resque"

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
  resources :problems do
    resources :solutions
  end
  resources :solutions
  resources :password_resets
end
