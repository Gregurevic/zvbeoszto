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

  get   '/courses'              =>   'course#index'
  get   'course_registration',  to:  'course#new'
  post  '/courses'              =>   'course#create'
  patch '/courses'              =>   'course#update'
  get   'destroy_course'        =>   'course#destroy'
  get   'edit_course',          to:  'course#edit'

  get   'student_registration',  to: 'student#new'
  post  'student_registration',  to: 'student#create'
  get   'destroy_student',       to: 'student#destroy'
  get   'edit_student',          to: 'student#profile'

  get   'instructor_registration',  to: 'instructor#new'
  post  'instructor_registration',  to: 'instructor#create'
  get   'destroy_instructor',       to: 'instructor#destroy'
  get   'edit_instructor',          to: 'instructor#profile'

  get   'examiners_list',    to: 'examiner#index'
  post  'create_examiner',   to: 'examiner#create'
  get   'destroy_examiner',  to: 'examiner#destroy'
end
