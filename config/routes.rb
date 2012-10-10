Deployer::Application.routes.draw do
  namespace :api do
    resource :build_status, only: :create
  end

  resources :projects, only: [ :index, :new, :create, :destroy ]
  root :to => 'projects#index'
end
