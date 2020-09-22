Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'navigation#home'

  get 'profile',   to: 'navigation#profile'
  get 'schedule',  to: 'navigation#schedule'
  get 'confirm',   to: 'navigation#confirm'

  get 'applicants',        to: 'admin#applicants'
  get 'current_schedule',  to: 'admin#current_schedule'

  get '/courses' => 'course#index'
  get 'course_registration',  to: 'course#new'
  post '/courses' => 'course#create'

  get   'student_registration', to: 'student#new'
  post  'student_registration', to: 'student#create'

  get   'instructor_registration', to: 'instructor#new'
  post  'instructor_registration', to: 'instructor#create'
end
