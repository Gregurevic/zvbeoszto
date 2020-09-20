Rails.application.routes.draw do
  devise_for :users
  root to: 'regular#home'

  get 'profile',   to: 'application#profile'
  get 'schedule',  to: 'application#schedule'

  get 'applicants',           to: 'admin#applicants'
  get 'current_schedule',     to: 'admin#current_schedule'

  get '/courses' => 'course#index'
  get 'course_registration',  to: 'course#new'
  post '/courses' => 'course#create'
end
