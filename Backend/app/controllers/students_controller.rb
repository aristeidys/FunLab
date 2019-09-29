class StudentsController < ApplicationController    
  before_action :set_student, only: [:show, :update, :destroy]
  
  #GET /students
  def index

    # GET /students?username=helloworld
    @students = if params[:username]
      Student.findByUsername(params[:username])
    else

    # GET /students
    Student.all
    end
    render json: @students
  end

  # GET /students/1
  def show
    render json: @student.to_json(only: [:id, :name, :username, :password])
  end

  # POST /students
  def create
    @student = Student.new(student_params)
    if @student.save
      render json: @student.to_json(only: [:id]), status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end
  # Only allow a trusted parameter "white list" through.
  def student_params
    params.fetch(:student).permit(:name, :username, :password)
  end
end