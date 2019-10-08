class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :update, :destroy]
    
  # CRUD
  
  def active
    @id = params[:classroom_id]
    render json: Student.joins(:enrollments).where({ enrollments: { isApproved: true, classroom_id:  @id} }).to_json()

  end

  def pending
    @id = params[:classroom_id]
    render json: Student.joins(:enrollments).where({ enrollments: { isApproved: false, classroom_id:  @id } }).to_json()

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
    @en = @enrollment.first
    if @en.present?
      @en.destroy
    end
  end
  
  private
      def set_enrollment
        @enrollment = Enrollment.where(classroom_id: params[:classroom_id], student_id: params[:student_id])
      end
      def enrollment_params
        params.require(:enrollment).permit(:classroom_id, :student_id, :isApproved)
      end
end
