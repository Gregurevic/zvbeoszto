Rails.application.routes.draw do
  root to: 'application#show'

  get 'profile',      to: 'users#edit'
  get 'my-schedule',  to: 'users#show'
  get 'signup',       to: 'users#create'
  get 'login',        to: 'users#login'

  get 'applicants',        to: 'schedules#create'
  get 'current-schedule',  to: 'schedules#show'
end
