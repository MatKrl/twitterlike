Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    get 'invite'
    get 'uninvite'
    get 'block'
    get 'unblock'
  end
  post 'comments/create',  to: "users#create_comment"
  get  'comments/destroy', to: "users#destroy_comment"

  root to: "users#dashboard"
end
