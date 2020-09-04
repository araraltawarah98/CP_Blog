Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret' }
  resources :blogs

  post 'comments/:id', to: 'comments#create', as: 'comments'
  get 'profile/:id', to: 'profile#index', as: 'profile_user'
  root to: 'blogs#index'
end
