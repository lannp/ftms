Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, path: "auth", path_names: {sign_in: "login", sign_out: "logout"}
  
  namespace :admin do
    root "users#index"
    resources :users
  end

  resources :courses do
    resources :user_subjects, only: :show
  end

  namespace :supervisor do
    root "subjects#index"
    resources :subjects
  end
end
