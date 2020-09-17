Rails.application.routes.draw do
  devise_for :users
  root to: 'application#home'

  get 'profile',   to: 'application#profile'
  get 'schedule',  to: 'application#schedule'

  get 'applicants',           to: 'admin#applicants'
  get 'current_schedule',     to: 'admin#current_schedule'
  get 'course_registration',  to: 'admin#course_registration'
end
