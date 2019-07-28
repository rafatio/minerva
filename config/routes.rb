Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  authenticated :user do
    root "home#index", as: :authenticated_root
  end

  devise_scope :user do
    root "devise/sessions#new", as: :unauthenticated_root
  end

  resources :payments, only: [:index, :new, :create]
  resources :profile, only: [:index, :create]
  #resources :mentors, only: :index
end
