Rails.application.routes.draw do
  root to:'static_pages#landing'
  get '/index_entreprise', to: 'static_pages#index_company',as: 'index_company'
  get '/index_individuel', to: 'static_pages#index_user',as: 'index_user'
  
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
  get 'account/requestcompany', to: "users#request_company", as: 'request_company'
  patch 'account/requestcompany', to: "users#update_company"
  patch 'validate_account/:id', to: "notifications#validate_account", as: 'validate_account'
  delete 'refuse_account/:id', to: "notifications#refuse_account", as: 'refuse_account'
  get '/account/user_request/:id', to: "users#user_request", as: 'account_user_request'
  get '/spotify', to: "users#spotify"
  get '/search', to: "users#spotify"
  get '/dashboard', to: 'users#dashboard'
  get '/dashboard/admin', to: 'users#dashboard_admin'
  get '/users/:id/feedbacks', to: 'feedbacks#user_feedbacks', as: 'users_feedbacks'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :feedbacks
  resources :users, only: [:show]

  get '/moon', to: 'application#moon', as: 'moon'
  get '/sun', to: 'application#sun', as: 'sun'



  resources :notifications, only: [:index, :create, :update, :destroy]

  resources :appointments


  # Active admin
  ActiveAdmin.routes(self)
  devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)


end
