class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :update, :destroy]
    
  # CRUD
  
  def index  
    render json: Classroom.find(params[:classroom_id]).enrollments.to_json()
  end
  
  def show
    render json: @enrollment.to_json()
  end
  
  def create
      @enrollment = Enrollment.new(enrollment_params)
      @enrollment.classroom_id = params[:classroom_id]
      @enrollment.student_id = params[:student_id]
    if @enrollment.save
      render json: @enrollment.to_json(), status: :created
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @enrollment.update(enrollment_params)
      render json: @enrollment
    else 
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @enrollment.destroy
  end
  
  private
      def set_enrollment
        @enrollment = Enrollment.find(params[:id])
      end
      def enrollment_params
        params.require(:enrollment).permit(:classroom_id, :student_id)
      end
end
