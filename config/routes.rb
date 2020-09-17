Rails.application.routes.draw do
  devise_for :users
  root to: 'application#home'

  get 'profile',      to: 'users#edit'
  get 'schedule',  to: 'users#show'
  get 'signup',       to: 'users#create'
  get 'login',        to: 'users#login'

  get 'applicants',        to: 'schedules#create'
  get 'current_schedule',  to: 'schedules#show'
end
