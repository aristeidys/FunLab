class ClassroomsController < ApplicationController   

  before_action :set_classroom, only: [:show, :update, :destroy]
  
  def index
    if params[:student_id]

      @classrooms = Student.find(params[:student_id]).classrooms.to_json()
    elsif params[:instructor_id]

      @classrooms = Classroom.findByParentID(params[:instructor_id])
    elsif params[:name]

      @classrooms = Classroom.findByName(params[:name])
    else

      @classrooms = Classroom.all
    end
      render json: @classrooms
  end

  # GET ONE
  def show
    render json: @classroom.to_json()
  end

  # POST
  def create
      @classroom = Classroom.new(classroom_params)
      @classroom.instructor_id = params[:instructor_id]
      if @classroom.save
        render json: @classroom.to_json(), status: :created
      else
        render json: @classroom.errors, status: :unprocessable_entity
      end
  end

  # UPDATE
  def update
    if @classroom.update(classroom_params)
      render json: @classroom
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @classroom.destroy
  end

  private
  def set_classroom
    @classroom = Classroom.find(params[:id])
  end
  def classroom_params
    params.fetch(:classroom).permit(:name, :instructor_id)
  end
end