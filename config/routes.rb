Electurer::Application.routes.draw do
  resources :access_tokens

  resources :universities
  resources :user_upgrade
  devise_for :users

  
  resource :profile

  match "/dashboard" => "dashboard#index", as: :dashboard
  match "/:screen_name" => "profiles#show", as: :profile_page, format: :html, constraints: { screen_name: /[^\/]+/ }

  root to: 'welcome#index'
end
