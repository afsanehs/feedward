Rails.application.routes.draw do
  root to:'static_pages#index'
  resources :feedbacks
  get 'static_pages/contact', as: 'contact'
  get 'static_pages/about', as: 'about'
  get 'static_pages/faq', as: 'faq'
  get 'static_pages/carreers', as: 'careers'
  get 'static_pages/news', as: 'news'
  get 'static_pages/reportproblem', as: 'report_problem'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :feedbacks

end
