Rails.application.routes.draw do
  devise_for :users, skip: [:session, :password, :registration], controllers: { omniauth_callbacks: "omniauth_callbacks" }
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    post "/add_member", to: "groups#add_member"
    delete "/remove_member", to: "groups#remove_member"
    get "/change_subtask", to: "tasks#change_subtask"
    get "/estimate", to: "tasks#estimate"
    devise_for :users, controllers: {
        confirmations: "confirmations" }, skip: [:omniauth_callbacks]
    get "/add_user_subtask", to: "tasks#add_user_to_subtask"
    resources :users, only: [:show, :edit, :update] do
      member do
        get :following, :followers
        match "search" => "users#search", via: [:get, :post], as: :search
        get :upgrade
        get :upgrade_leader
      end
    end
    resources :groups do
      resources :tasks
      get "statistic", to: "tasks#statistic"
      member do
        match "search" => "groups#search", via: [:get, :post], as: :search
      end
    end
    resources :reports, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]
    namespace :admin do
      resources :users, only: [:index] do
        patch "/active_leader", to: "users#active_leader"
      end
    end
    resources :tasks
  end
end
