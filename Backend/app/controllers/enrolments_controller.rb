class EnrolmentsController < ApplicationController



    before_action :set_enrolment, only: [:show, :update, :destroy]
    

      
  def index

    # GET /enrolments

    @enrolments = Enrolment.all
    
    render json: @enrolments
  end

  # GET /enrolments/23
  def show
    render json: @enrolments
  end

  # POST /enrolments
  def create

    # else 
      @enrolment = Enrolment.new(enrolment_params)
      if @enrolment.save
        render :show, status: :created, location: @enrolment
      else
        render json: @enrolment.errors, status: :unprocessable_entity
      end
    # end
  end
  
  def update
    if @enrolment.update(enrolment_params)
      render :show, status: :ok, location: @enrolment
    else 
      render json: @enrolment.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @enrolment.destroy
  end
  
  private
      def set_enrolment
        @enrolment = Enrolment.find(params[:id])
      end
      def enrolment_params
        params.require(:enrolment).permit(:points, :lab_session_id, :student_id)
      end
end
