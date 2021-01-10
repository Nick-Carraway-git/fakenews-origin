Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations' }
  resources :users,               only: [:show]
  resources :articles,            only: [:show, :new, :create, :destroy, :edit]
  resources :relationships,       only: [:create, :destroy]
  resources :boardrooms,          only: [:show, :create]
  resources :favorites,           only: [:create, :destroy]

  resources :users do
    member do
      get :following, :followers
    end
  end

  root 'foundational_pages#index'
  get '/',                        to: 'foundational_pages#index'
  get '/index',                   to: 'foundational_pages#index'
  get '/help',                    to: 'foundational_pages#help'
  get '/terms',                   to: 'foundational_pages#terms'
  get '/aboutus',                 to: 'foundational_pages#aboutus'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
