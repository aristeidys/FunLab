class StudentsController < ApplicationController
  
    before_action :set_labSession, only: [:show, :update, :destroy]
    
    # GET /student/23
    def show
      render json: @student
    end
  
    # POST /student
    def create
      @student = Student.new(student_params)
      if @student.save
        render :show, status: :created, location: @student
      else
        render json: @student.errors, status: :unprocessable_entity
      end
    end
    
    def update
      if @student.update(student_params)
        render :show, status: :ok, location: @student
      else 
        render json: @student.errors, status: :unprocessable_entity
      end
    end
    
    def destroy
      @student.destroy
    end
    
    private
        def set_student
          @student = Student.find(params[:id])
        end
        def student_params
          params.require(:student).permit(:name)
        end
  end
  