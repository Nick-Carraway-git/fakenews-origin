Rails.application.routes.draw do
  devise_for :users, controllers: {
                                  omniauth_callbacks: 'users/omniauth_callbacks',
                                  registrations: 'users/registrations', }
  resources :users,               only: [:index, :show]
  resources :articles,            only: [:index, :show, :new, :edit, :update, :create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :boardrooms,          only: [:show, :create]
  resources :favorites,           only: [:create, :destroy]
  resources :minimails,           only: [:show, :new, :create, :destroy]
  resources :contacts,            only: [:new, :create]

  resources :users do
    member do
      get :following, :followers
      get :favoring
      get :recieved, :sended
    end
  end

  root 'foundational_pages#index'
  get '/',                        to: 'foundational_pages#index'
  get '/index',                   to: 'foundational_pages#index'
  get '/help',                    to: 'foundational_pages#help'
  get '/terms',                   to: 'foundational_pages#terms'
  get '/aboutus',                 to: 'foundational_pages#aboutus'
  get '/search',                  to: 'foundational_pages#search'
  get '/results',                 to: 'foundational_pages#results'
  devise_scope :user do
    post 'users/guest_log_in', to: 'users/sessions#guest_log_in'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
