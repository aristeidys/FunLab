class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :update, :destroy]
  

  def index

      # GET /task?lab_session_id=34

    @tasks = if params[:lab_session_id]
      Task.search_by_lab_session_id(params[:lab_session_id])
    else
        # GET /tasks

      Task.all
    end
    @tasks = @tasks.title(params[:title]) if params[:title].present?
    
    render json: @tasks
  end
  
  # GET /tasks/21
  def show
    render json: @task
  end
  
  # POST /tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      render :show, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @task.update(task_params)
      render :show, status: :ok, location: @task
    else 
      render json: @task.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @task.destroy
  end
  
  private
      def set_task
        @task = Task.find(params[:id])
      end
      def task_params
        params.require(:task).permit(:title, :lab_session_id)
      end
end
