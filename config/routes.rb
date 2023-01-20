Rails.application.routes.draw do
  resources :log_entries
  resources :feedbacks
  root "pages#home"

  devise_for :user_accounts, controllers: {
                             sessions: "user_accounts/sessions",
                             registrations: "user_accounts/registrations",
                           }


  resources :requests do
    collection do
      match 'search' => 'requests#search', via: [:get, :post], as: :search
    end
  end
  
  resources :requests do
    member do
      get :change_status
    end
  end

  get '/request_work_buildings', to: 'requests#work_buildings'

  get 'reports', to: 'requests#reports'
  get 'ask_state', to: 'requests#ask_state'
  post 'ask_state', to: 'requests#search_state'

  get '/tasks/edit', to: 'tasks#edit', as: 'edit_task'
  post '/tasks/edit', to: 'tasks#update'
  resources :tasks, except: [:show]

  resources :employees do
    collection do
      match 'search' => 'employees#search', via: [:get, :post], as: :search
    end
  end

end
