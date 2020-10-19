Rails.application.routes.draw do
  root to: 'navigation#home'

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    patch 'update_user_registration' => 'devise/registrations#update'
  end

  get 'schedule',  to: 'schedule#show'

  get 'applicants',        to: 'admin#applicants'
  get 'current_schedule',  to: 'admin#current_schedule'

  get    '/courses'              =>   'course#index'
  get    'course_registration',  to:  'course#new'
  post   '/courses'              =>   'course#create'
  patch  '/courses'              =>   'course#update'
  get    'destroy_course'        =>   'course#destroy'
  get    'edit_course',          to:  'course#edit'

  get    'student_registration',  to: 'student#new'
  post   'student_registration',  to: 'student#create'
  get    'destroy_student',       to: 'student#destroy'
  get    'edit_student',          to: 'student#profile'
  patch  'student_registration',  to: 'student#update'
  get    'destroy_all_students',  to: 'student#destroy_all'

  get    'instructor_registration',  to: 'instructor#new'
  post   'instructor_registration',  to: 'instructor#create'
  get    'destroy_instructor',       to: 'instructor#destroy'
  get    'edit_instructor',          to: 'instructor#profile'
  patch  'instructor_registration',  to: 'instructor#update'

  get   'new_examiner',      to: 'examiner#new'
  post  'create_examiner',   to: 'examiner#create'
  get   'destroy_examiner',  to: 'examiner#destroy'
end
