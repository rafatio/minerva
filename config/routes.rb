Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "home#index"
  devise_for :users

  resources :payments, only: [:index, :new, :create]
  #resources :mentors, only: :index
end
