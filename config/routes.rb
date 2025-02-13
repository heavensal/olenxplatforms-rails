Rails.application.routes.draw do
  root "others/pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions", confirmations: "users/confirmations", passwords: "users/passwords", unlocks: "users/unlocks" }

  resources :portfolios, only: [:index, :show] do
    resources :ideas, only: [:index, :show]
    resources :projects, only: [:index, :show]
  end

  resources :ideas, only: [:index, :show]
  resources :projects, only: [:index, :show]

  namespace :dashboard do
    resource :portfolio, only: [:show, :edit, :update] do
      resources :ideas, except: [:destroy]
      resources :projects, except: [:destroy]
    end

    resources :ideas, only: [:destroy]
    resources :projects, only: [:destroy]
  end

  resources :reactions, only: [:create, :update, :destroy]

  namespace :admin do
    resources :users
    resources :portfolios
    resources :ideas
    resources :projects
  end
end
