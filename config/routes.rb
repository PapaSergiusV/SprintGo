Rails.application.routes.draw do
  
  resources :items
  resources :companies do
    resources :roles, only: [:create, :destroy]
    resources :projects do
      resources :project_roles
      resources :sprints
      resources :tasks
    end
  end

  get '/companies/:company_id/employees' => 'companies#employees_list'
  get '/roles/companies_list/:user_id' => 'roles#companies_list'
  get '/all_users' => 'users#index'

  post 'authenticate' => 'authentication#authenticate'
  post 'signup' => 'authentication#signup'

end
