POP::Application.routes.draw do

  require 'resque/server'
  mount Resque::Server.new, :at => "/resque"

  root :to => "problems#index"
  match "/logout" => "sessions#destroy", :as => "logout"
  match "/settings" => "settings#show", :as => 'settings'
  match "/login" => "sessions#new", :as => "login"
  match "/signup/welcome" => "signup#edit", :as => "welcome"
  match "/about" => "info#about", :as => "about"
  match "/signup" => "users#new", :as => "signup"

  match "/auth/:provider/callback" => "oauth#create"
  match "auth/failure", :to => redirect('/')

  resources :comments, :only => [:new, :create, :destroy]
  resources :embeds, :only => [:show]
  resources :existing_problem_votes, :only => [:create]
  resources :existing_solution_votes, :only => [:create]
  resources :issues, :only => [:show]
  resources :notifications, :only => [:update]
  resources :oauth, :only => [:create]
  resources :password_resets
  resources :politicians, :only => [:show] do
    resources :problems, :only => [:new, :create]
  end
  resources :problems do
    resources :solutions
  end
  resources :problem_upvotes, :only => [:create]
  resources :problem_downvotes, :only => [:create]
  resources :profiles
  resources :signup, :only => [:edit, :update]
  resources :solution_upvotes, :only => [:create]
  resources :solution_downvotes, :only => [:create]
  resources :solutions
  resource  :session
  resources :sessions
  resources :settings, :only => [:show]
  resources :users
  resources :widgets, :only => [:new, :create, :show]

  namespace :api do
    namespace :v1 do
      match "/login" => "sessions#new", :as => "login"
      resources :politicians, :only => [] do
        resources :problems,  :only => [:new, :create, :index]
      end
      resource  :session,     :only => [:create]
      resources :sessions,    :only => [:new, :create]
    end
  end
end
