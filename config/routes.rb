Rails.application.routes.draw do
  resources :tasks
  resources :employees
  resources :requests
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
end
