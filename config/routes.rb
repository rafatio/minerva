# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Blazer::Engine, at: "reports"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  Healthcheck.routes(self)

  authenticated :user do
    root 'home#index', as: :authenticated_root
  end

  devise_scope :user do
    root 'devise/sessions#new', as: :unauthenticated_root
  end

  resources :deploy, only: %i[index]

  resources :payments, only: %i[index new create]
  resources :profile, only: %i[index create]
  resources :subscriptions, only: %i[new create]
  # resources :mentors, only: :index
  resources :postback, only: [:create]

end
