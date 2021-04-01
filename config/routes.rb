Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'top#index'

  get '/purchases/record', to: 'purchases#record'

  resources :users, only: [:show] do
    get :post_list, on: :member
    get :deal_list, on: :member
  end

  resources :posts do
    resources :purchases
  end

  resources :rooms, only: [:new, :create, :show]
end
