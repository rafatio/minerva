Rails.application.routes.draw do
  root to: "users#show"
  devise_for :users

  resources :payments, only: [:index, :new, :create]
  resources :mentors, only: :index
  resources :users, only: :show
end
