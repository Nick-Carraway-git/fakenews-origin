Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'foundational_pages#index'
  get '/',                        to: 'foundational_pages#index'
  get '/index',                   to: 'foundational_pages#index'
  get '/help',                    to: 'foundational_pages#help'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
