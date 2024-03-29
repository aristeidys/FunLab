class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :update, :destroy]
  
  def index

    if params[:session_id] && params[:student_id]

      @tasks = Task.where(session_id: params[:session_id])
      @tasksWithTaskResult = @tasks.joins(:task_results).where({ task_results: {student_id: params[:student_id]}})

      if @tasksWithTaskResult.count < @tasks.count

        @tasks.each do |n|
          @tr = TaskResult.new()
          @tr.task_id = n.id
          @tr.student_id = params[:student_id]
          @tr.task_name = n.name
          @tr.save
        end
      end
      
      @task_results_to_return = []    
      @tasks.each do |task|
        @task_results_to_return << TaskResult.where(student_id: params[:student_id], task_id: task.id)     
      end

      logger.debug @task_results_to_return.count
      logger.debug @tasks.count

      render json: @task_results_to_return
    elsif params[:session_id]
      
      @tasks = Task.findBySessionID(params[:session_id])
      render json: @tasks
    end
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
