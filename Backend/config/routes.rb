Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions, defaults: {format: :json}  do
    resources :tasks
  end
  resources :modules, defaults: {format: :json}
  resources :students, defaults: {format: :json}  do
    resources :task_results
    resources :session_results
  end
  resources :instructors, defaults: {format: :json} do 
    resources :modules
  end
end
