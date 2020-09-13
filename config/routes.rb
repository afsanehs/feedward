Rails.application.routes.draw do
  root to:'static_pages#index'

  # Static page
  get '/contact', to: 'static_pages#contact',as: 'contact'
  get '/about', to: 'static_pages#about',as: 'about'
  get '/team', to: 'static_pages#team',as: 'team'
  get '/careers', to: 'static_pages#careers',as: 'careers'
  get '/legalnotice', to: 'static_pages#legal_notice',as: 'legal_notice'
  get '/privacypolicy', to: 'static_pages#privacy_policy',as: 'privacy_policy'

  # Custom urls user
  get 'account/profile', to: "users#profile", as: 'profile'
  patch 'account/profile', to: "users#update_profile"
  get 'account/secret', to: "users#secret"
  get '/spotify', to: "users#spotify"
  get '/search', to: "users#spotify_search"
  get '/dashboard', to: 'users#dashboard'
  get '/dashboard/admin', to: 'users#dashboard_admin'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :feedbacks
  resources :users, only: [:show]


end
