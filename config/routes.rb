Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  resources :payments, only: [:index, :new, :create]
  #resources :mentors, only: :index
end
