class StudentsController < ApplicationController
  
    before_action :set_labSession, only: [:show, :update, :destroy]
    

      
  def index
    # GET /students?name=hello

    @students = if params[:name]
      Student.search_by_name(params[:name])
    else
        # GET /students

        Student.all
    end
    @students = @students.findByName(params[:name]) if params[:name].present?
    
    render json: @students
  end

  # GET /students/23
  def show
    render json: @student
  end

  # POST /students
  def create

    # else 
      @student = Student.new(student_params)
      if @student.save
        render :show, status: :created, location: @student
      else
        render json: @student.errors, status: :unprocessable_entity
      end
    # end
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
  