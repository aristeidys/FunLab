class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :update, :destroy]

  def index
    if params[:isApproved] && params[:classroom_id]
      @students = Student.joins(:enrollments).where({ enrollments: { isApproved: params[:isApproved], classroom_id:  params[:classroom_id]} })
    end

    render json: @students
  end
  
  def create
      @enrollment = Enrollment.new(enrollment_params)
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
        @enrollment = Enrollment.where(classroom_id: params[:classroom_id], student_id: params[:student_id]).first
      end

      def enrollment_params
        params.require(:enrollment).permit(:classroom_id, :student_id, :isApproved)
      end
end
