Rails.application.routes.draw do

  root 'users#index'

  resources :users
  resources :questions, except: [:show, :new, :index]
  resource :session, only: [:new, :create, :destroy]
  resources :hashtags, only: [:show]
  # get 'sign_up' => 'users#new'
  # get 'log_out' => 'sessions#destroy'
  # get 'log_in' => 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'show' => 'user#show'

end
