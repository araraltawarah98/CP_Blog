Rails.application.routes.draw do

  resources :comments
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret' }
  resources :blogs

  get 'profile/:id', to: 'profile#index', as: 'profile_user'
  root to: 'blogs#index'
end
