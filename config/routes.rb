Electurer::Application.routes.draw do
  resources :universities
  resources :user_upgrade
  devise_for :users

  match "/:screen_name" => "profiles#show", as: :profilesss
  resource :profile

  match "/dashboard" => "dashboard#index", as: :dashboard

  root to: 'welcome#index'
end
