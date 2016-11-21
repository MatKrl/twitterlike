Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    get 'invite'
    get 'uninvite'
    get 'block'
    get 'unblock'
  end

  root to: "users#dashboard"
end
