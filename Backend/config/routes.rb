Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :lab_sessions, defaults: {format: :json}  do
    resources :activities
    resources :enrolments
  end
  resources :activities, defaults: {format: :json}
  
  resources :students, defaults: {format: :json}  do
    resources :enrolments
  end
  resources :enrolments, defaults: {format: :json}
end
