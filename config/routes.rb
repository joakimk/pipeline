Deployer::Application.routes.draw do
  namespace :api do
    resource :build_status, only: :create
  end

  resources :projects, except: :show
  root :to => 'projects#index'
end
