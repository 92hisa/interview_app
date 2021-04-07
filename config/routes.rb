Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tops#index'

  resources :users, only: [:show, :update] do
    get :post_list, on: :member
    get :purchase_logs, on: :member
  end

  resources :posts do
    resources :purchases
  end

  resources :rooms
  resources :messages, only: [:index, :create]
  post 'rooms/:id' => 'rooms#show'
end
