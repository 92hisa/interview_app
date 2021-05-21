Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tops#index'
  get '/search', to: 'posts#search', as: :search

  resources :users, only: [:show, :update] do
    get :post_list, on: :member
    get :purchase_logs, on: :member
    get :favorite_list, on: :member
    get :follows, on: :member
    get :dm_list, on: :member
  end

  resources :posts do
    resources :purchases do
      resources :reviews, only: [:new, :create]
    end
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  resources :rooms
  resources :messages, only: [:index, :create]
  post 'rooms/:id' => 'rooms#show'

  resources :categories
  resources :relationships, only: [:create, :destroy]

  resources :notifications, only: :index do
    collection do
      delete 'destroy_all'
    end
  end
  resources :dms, only: [:create]
  resources :dm_rooms, only: [:create,:show]
  resources :recruitments, only: [:index]
end
