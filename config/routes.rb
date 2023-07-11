Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    member do
      get :reservations
    end
  end
  get 'rooms/search', to: 'rooms#search', as: 'search_rooms'
  resources :rooms
  resources :reservations, only: [:show, :new, :create, :edit, :update, :index]
  root to: 'home#index'
  resources :users do
    member do
      get :edit_account
      get :edit_profile
    end
  end  
end
