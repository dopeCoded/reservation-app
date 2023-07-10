Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    member do
      get :reservations
    end
  end
  resources :rooms
  resources :reservations, only: [:show, :new, :create, :edit, :update, :index]
  root to: 'home#index'
end
