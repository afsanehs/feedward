Rails.application.routes.draw do
  root to:'static_pages#landing'

  devise_for :users
  # Fix problem of sign out button devise
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
  resources :accounts, only: [:index, :create]
  resources :request_companies, only: [:index, :create]
  # get 'account/requestcompany', to: "users#request_company", as: 'request_company'
  # patch 'account/requestcompany', to: "users#update_company"
  get '/account/user_request/:id', to: "users#user_request", as: 'account_user_request'


  get '/users/:id/feedbacks', to: 'feedbacks#user_feedbacks', as: 'users_feedbacks'
  patch 'validate_account/:id', to: "notifications#validate_account", as: 'validate_account'
  delete 'refuse_account/:id', to: "notifications#refuse_account", as: 'refuse_account'


  # Custom routes for Spotify
  get '/spotify', to: "users#spotify"
  get '/search', to: "users#spotify"

  #Custom routes for the dashboards
  get '/company_user_new', to: 'companies#company_user_new', as: 'company_user_new'
  post '/company_user_new', to: 'companies#company_user_create'

end
