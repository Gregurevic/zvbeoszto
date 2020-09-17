Rails.application.routes.draw do
  devise_for :users
  root to: 'application#home'

  get 'profile',   to: 'application#edit'
  get 'schedule',  to: 'application#show'

  get 'applicants',           to: 'admin#applicants'
  get 'current_schedule',     to: 'admin#current_schedule'
  get 'course_registration',  to: 'admin#course_registration'
end
