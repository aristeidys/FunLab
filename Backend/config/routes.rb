Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :classrooms, defaults: {format: :json} do 
    resources :sessions
    resources :enrollments
  end
  
  resource :enrollments, only: [:show, :update, :destroy, :create]
  resource :task_results, only: [:update]

  resources :sessions, defaults: {format: :json} do
    resources :tasks
  end
  
  resources :students, defaults: {format: :json} do
    resources :tasks
    resources :session_results
    resources :classrooms
  end
  
  resources :instructors, defaults: {format: :json} do 
    resources :classrooms
  end
end
