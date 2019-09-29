class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :update, :destroy]
  

  def index

    # FIND
    @tasks = if params[:name]
      Task.findByName(params[:name])
    else
    
      # GET ALL
      Task.all
    end    
    render json: @tasks
  end
  
  # GET ONE
  def show
    render json: @task.to_json()
  end
  
  # POST
  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task.to_json(), status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end
  
  # UPDATE
  def update
    if @task.update(task_params)
      render json: @task
    else 
      render json: @task.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE
  def destroy
    @task.destroy
  end
  
  private
      def set_task
        @task = Task.find(params[:id])
      end
      def task_params
        params.require(:task).permit(:name, :session_id, :difficulty)
      end
end
