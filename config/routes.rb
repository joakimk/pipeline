Pipeline::Application.routes.draw do
  namespace :api do
    resource :build_status, only: :create
    delete "projects/:name" => "projects#destroy"
    resource :build, only: [] do
      collection do
        post :lock
        post :unlock
      end
    end
  end

  resources :projects
  root :to => 'projects#index'
end
