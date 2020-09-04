Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret' }
  resources :blogs

  get 'comments/:id', to: 'comment#create', as: 'comments'
  get 'profile/:id', to: 'profile#index', as: 'profile_user'
  root to: 'blogs#index'
end
