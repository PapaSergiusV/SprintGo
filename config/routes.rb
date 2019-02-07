Rails.application.routes.draw do
  devise_for :users

  resources :companies do
    resources :roles

    resources :projects do
      resources :project_roles
      resources :sprint
      resources :tasks
    end
  end

end
