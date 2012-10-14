POP::Application.routes.draw do

  require 'resque/server'
  mount Resque::Server.new, :at => "/resque"

  root :to => "users#new"
  match "/logout" => "sessions#destroy", :as => "logout"
  match "/settings" => "settings#show", :as => 'settings'
  match "/login" => "sessions#new", :as => "login"
  match "/signup/welcome" => "signup#edit", :as => "welcome"
  match "/about" => "info#about", :as => "about"

  match "/auth/:provider/callback" => "oauth#create"
  match "auth/failure", :to => redirect('/')

  resources :oauth, :only => [:create]
  resources :signup, :only => [:edit, :update]
  resources :settings
  resources :users
  resources :profiles
  resource :session
  resources :sessions
  resources :issues, :only => [:show]
  resources :problems do
    resources :solutions
  end
  resources :solutions
  resources :comments, :only => [:new, :create, :destroy]
  resources :password_resets
  resources :problem_upvotes, :only => [:create]
  resources :problem_downvotes, :only => [:create]
  resources :solution_upvotes, :only => [:create]
  resources :solution_downvotes, :only => [:create]
  resources :existing_problem_votes, :only => [:create]
  resources :existing_solution_votes, :only => [:create]
end
