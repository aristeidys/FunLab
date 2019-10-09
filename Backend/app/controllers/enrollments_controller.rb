class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :update, :destroy]

  def index
    if params[:isApproved] && params[:classroom_id]
      @enrollments = Enrollment.where(isApproved: params[:isApproved],classroom_id: params[:classroom_id])
    elsif
      @enrollments = Enrollment.all
    end

    render json: @enrollments
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
    @enrollment.isApproved = true

    if @enrollment.save
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
