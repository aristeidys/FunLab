class TaskResultsController < ApplicationController
  
    before_action :set_task_result, only: [:show, :update, :destroy]
    
    def index  
      render json: Student.find(params[:student_id]).task_results.to_json()
    end
    
    # GET ONE

    def show
      render json: @tr.to_json()
    end
    
    # POST

    def create
        @tr = TaskResult.new(task_result_params)
        @tr.task_id = params[:task_id]
        @tr.student_id = params[:student_id]
      if @tr.save
        render json: @tr.to_json(), status: :created
      else
        render json: @tr.errors, status: :unprocessable_entity
      end
    end
    
    # UPDATE
    
    def update
      if @tr.update(task_result_params)
        render json: @tr
      else 
        render json: @tr.errors, status: :unprocessable_entity
      end
    end
    
    # DELETE
    def destroy
      @tr.destroy
    end
    
    private
        def set_task_result
          @tr = TaskResult.findByStudentTaskID(params[:student_id], params[:task_id]).first
        end
        def task_result_params
          params.require(:task_result).permit(:task_id, :student_id, :completed)
        end
  end
  