Rails.application.routes.draw do
  resources :task_observations
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  devise_for :user_accounts, controllers: {
                             sessions: "user_accounts/sessions",
                             registrations: "user_accounts/registrations",
                           }

  resources :requests do
    member do
      get :change_status
    end
  end

  get '/tasks/edit', to: 'tasks#edit', as: 'edit_task'
  post '/tasks/edit', to: 'tasks#update'
  resources :tasks, except: [:show]

  resources :employees
  post 'status_filter', action: :status_filter, controller: 'employees'
  resources :requests

end
