Pipeline::Application.routes.draw do
  namespace :api do
    resource :build_status, only: :create
    resource :build, only: [] do
      collection do
        post :lock
        post :unlock
      end
    end
  end

  resources :projects, except: :show
  root :to => 'projects#index'
end
