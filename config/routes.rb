Rails.application.routes.draw do
  devise_for :users

  resources :companies do
    resources :roles, only: [:create, :destroy]
    resources :projects do
      resources :project_roles
      resources :sprints
      resources :tasks
    end
  end

  get '/companies/:company_id/workers' => 'companies#workers'

end
