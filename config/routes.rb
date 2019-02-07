Rails.application.routes.draw do
  devise_for :users

  resources :companies do
    resources :roles
    resources :projects do
      resources :project_roles
      resources :sprints
      resources :tasks
    end
  end

  get '/company_projects/:company_id' => 'projects#index'

end
