Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show] do
    get 'invite'
    get 'uninvite'
    get 'block'
    get 'unblock'
  end

  resources :messages, only: [:create]
  resources :comments, only: [:create]

  root to: "users#dashboard"
end
