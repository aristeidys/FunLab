Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :labsessions, defaults: {format: :json}  do
    resources :tasks
  end
  resources :classrooms, defaults: {format: :json}
  resources :students, defaults: {format: :json}  do
    resources :task_results
    resources :labsession_results
  end
  resources :instructors, defaults: {format: :json} do 
    resources :classrooms
  end
end
