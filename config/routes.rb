Electurer::Application.routes.draw do
  mount Resque::Server.new, at: "/worker"
  resources :access_tokens
  resources :user_upgrade
  devise_for :users
  
  resource :profile do
    get :basic_info, on: :collection
    put :update_basic_info, on: :collection
  end

  match "/explore" => "explore#index", as: :explore
  match "/dashboard" => "dashboard#index", as: :dashboard
  
  scope "/:screen_name", constraints: { screen_name: /[A-Z\.0-9]+/i } do
    match "/" => "profiles#dashboard", as: :profile_page
    match "/information" => "profiles#show", as: :information
    resource :friendship
    resources :timelines
    resources :posts do
      resources :comments
    end
  end

  root to: 'welcome#index'
end
