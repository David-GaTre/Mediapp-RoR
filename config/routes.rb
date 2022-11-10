Rails.application.routes.draw do

  resources :meetings
  resources :offices
  resources :patients
  resources :doctors
  
  root "dashboards#index"

  post '/register_office', to: 'patients#register_office'
  post '/scheduler_meeting', to: 'patients#schedule_meeting', as: 'meetings_scheduler'
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
