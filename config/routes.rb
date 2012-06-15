Electurer::Application.routes.draw do

  resources :access_tokens
  resources :user_upgrade
  devise_for :users
  
  resource :profile do
    get :basic_info, on: :collection
    put :update_basic_info, on: :collection
  end

  match "/explore" => "explore#index", as: :explore
  match "/dashboard" => "dashboard#index", as: :dashboard
  
  scope "/:screen_name", format: :html, constraints: { screen_name: /[^\/]+/ } do
    match "/" => "profiles#dashboard", as: :profile_page
    match "/information" => "profiles#show", as: :information
    resource :friendship
    resource :timeline
  end

  root to: 'welcome#index'
end
