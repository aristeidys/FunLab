Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
  match 'classrooms/:classroom_id/enrollments/active' => 'enrollments#active', :via => :get
  match 'classrooms/:classroom_id/enrollments/pending' => 'enrollments#pending', :via => :get

  resources :classrooms, defaults: {format: :json} do 
    resources :sessions
    resources :enrollments
  end

  resources :sessions, defaults: {format: :json} do
    resources :tasks
  end
  
  resources :students, defaults: {format: :json} do
    resources :task_results
    resources :session_results
  end
  
  resources :instructors, defaults: {format: :json} do 
    resources :classrooms
  end
end
