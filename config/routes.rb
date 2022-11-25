Rails.application.routes.draw do

  resources :meetings
  resources :offices
  resources :patients
  resources :doctors
  resources :prescriptions
  resources :entries
  
  root "dashboards#index"
  post 'entries/new', to: 'entries#new'
  post 'prescriptions/new', to: 'prescriptions#new'


  post '/register_office', to: 'patients#register_office'
  post 'prescription#download_prescription', action: :download_prescription, controller: 'prescriptions'
  get '/office_info', to: 'offices#show_info', as: 'office_info' 
  get '/my_meetings', to: 'meetings#show_my_meetings', as: 'show_my_meetings' 
  post '/scheduler_meeting', to: 'patients#schedule_meeting', as: 'meetings_scheduler'
  devise_for :users, controllers: {
    registrations: "users/registrations",
    confirmations: "users/confirmations"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
