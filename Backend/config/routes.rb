Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :tasks, defaults: {format: :json}
  
  resources :classrooms, defaults: {format: :json} do 
    resources :sessions
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
