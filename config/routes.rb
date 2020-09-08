Rails.application.routes.draw do
  root to:'static_pages#index'
  get 'static_pages/contact', as: 'contact'
  get 'static_pages/about', as: 'about'
  get 'static_pages/team', as: 'team'
  get 'static_pages/careers', as: 'careers'
  get 'static_pages/legal', as: 'legal'
  get 'static_pages/privacy', as: 'privacy'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :feedbacks

end
