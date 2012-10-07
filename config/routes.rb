Deployer::Application.routes.draw do
  namespace :api do
    resource :status, only: :create
  end

  resources :projects, only: [ :index, :new, :create ]
  root :to => 'projects#index'
end
