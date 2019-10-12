class TaskResultsController < ApplicationController
  
    before_action :set_task_result, only: [:show, :update, :destroy]
    
    # GET ONE

    def show
      @taskResults = Student.find(params[:student_id]).task_results
      @taskResults = @taskResults.joins(:task).where(['tasks.session_id = ?', params[:session_id]])
      render json: @taskResults.to_json()
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
  