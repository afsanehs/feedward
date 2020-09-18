Rails.application.routes.draw do
  root to:'static_pages#landing'

  # Routes from our model
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  
  resources :users, only: [:show]
  resources :feedbacks, except: [:destroy]
  resources :notifications, only: [:index, :create, :update, :destroy]
  resources :appointments
  resources :companies, only: [:new, :create, :edit, :update]
  
  # Active admin
  ActiveAdmin.routes(self)
  devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)

  
  # Static page
  get '/contact', to: 'static_pages#contact',as: 'contact'
  get '/about', to: 'static_pages#about',as: 'about'
  get '/careers', to: 'static_pages#careers',as: 'careers'
  get '/legalnotice', to: 'static_pages#legal_notice',as: 'legal_notice'
  get '/privacypolicy', to: 'static_pages#privacy_policy',as: 'privacy_policy'
  get '/landing_employees', to: 'static_pages#landing_employees',as: 'landing_employees'
  

  # Custom urls user
  get 'account/profile', to: "users#profile", as: 'profile'
  patch 'account/profile', to: "users#update_profile"
  get 'account/requestcompany', to: "users#request_company", as: 'request_company'
  patch 'account/requestcompany', to: "users#update_company"
  get '/account/user_request/:id', to: "users#user_request", as: 'account_user_request'


  # namespace :account do
  #   get 'profile', to: "users#profile", as: 'profile'
  #   patch 'profile', to: "users#update_profile"
  #   get 'requestcompany', to: "users#request_company", as: 'request_company'
  #   patch 'requestcompany', to: "users#update_company"
  #   get 'user_request/:id', to: "users#user_request", as: 'account_user_request'
  # end
  
  get '/users/:id/feedbacks', to: 'feedbacks#user_feedbacks', as: 'users_feedbacks'
  patch 'validate_account/:id', to: "notifications#validate_account", as: 'validate_account'
  delete 'refuse_account/:id', to: "notifications#refuse_account", as: 'refuse_account'



  # Custom routes for Spotify
  get '/spotify', to: "users#spotify"
  get '/search', to: "users#spotify"


  #Custom routes for the dashboards
  #get '/dashboard', to: 'users#dashboard'
  #get '/dashboard/admin', to: 'users#dashboard_admin'

  #Custom routes for the dashboards
  get '/company_user_new', to: 'companies#company_user_new', as: 'company_user_new'
  post '/company_user_new', to: 'companies#company_user_create'

end
