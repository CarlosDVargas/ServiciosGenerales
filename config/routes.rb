Rails.application.routes.draw do
  resources :log_entries, only: [:index]
  
  resources :feedbacks, only: %i[new create show]

  root "pages#home"

  devise_for :user_accounts, controllers: {
    sessions: "user_accounts/sessions",
    registrations: "user_accounts/registrations",
  }

  resources :user_accounts, only: %i[index show] do
    collection do
      match 'search' => 'user_accounts#search', via: %i[get post], as: :search
    end
    member do
      put :change_status
    end
  end

  get '/employees', to: 'user_accounts#index', as: 'employees'

  resources :requests, only: %i[index show edit update new create] do
    collection do
      match 'search' => 'requests#search', via: %i[get post], as: :search
    end
  end

  resources :requests, only: %i[index show edit update new create] do
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
  resources :tasks, except: %i[show delete]

end
