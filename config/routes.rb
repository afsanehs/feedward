Rails.application.routes.draw do
  root to:'static_pages#landing'

  # Devise routes
  devise_for :users
  devise_scope :user do
    # Fix problem of sign out button devise
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # Active admin
  ActiveAdmin.routes(self)
  devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)

  # priciple controller for model
  resources :users, only: [:show]
  resources :feedbacks, except: [:destroy]
  resources :notifications, only: [:index, :create, :update, :destroy]
  resources :appointments
  resources :companies, only: [:new, :create, :edit, :update]
  
  # Custom urls user
  resources :accounts, only: [:index, :create]
  resources :request_companies, only: [:index, :create]
  resources :request_users, only: [:show]
  resources :company_users, only: [:new, :create]
  resources :notification_accounts, only: [:update, :destroy]
  resources :users do
    resources :user_feedbacks, only: [:index]
  end

  
  # Static page
  get '/contact', to: 'static_pages#contact',as: 'contact'
  get '/about', to: 'static_pages#about',as: 'about'
  get '/careers', to: 'static_pages#careers',as: 'careers'
  get '/legalnotice', to: 'static_pages#legal_notice',as: 'legal_notice'
  get '/privacypolicy', to: 'static_pages#privacy_policy',as: 'privacy_policy'
  get '/landing_employees', to: 'static_pages#landing_employees',as: 'landing_employees'
  

end
