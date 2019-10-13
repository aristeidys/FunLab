class ClassroomsController < ApplicationController   

  before_action :set_classroom, only: [:show, :update, :destroy]
  
  def index
    
    if params[:name] && params[:student_id]

    @classroom = Classroom.findByName(params[:name]).first

    if @classroom == nil
      render json: @classroom, :status => :not_found 
      return
    end

    @enrollment = Enrollment.findByStudentClassroom(params[:student_id], @classroom.id).first

      if @enrollment != nil
        if @enrollment.isApproved == true
          render json: @classroom
          return
        end
        render json: @classroom, :status => :unauthorized 
        return
      elsif
        render json: @classroom, :status => :unauthorized 
        return
      end

    elsif params[:student_id]

      @classrooms = Student.find(params[:student_id]).classrooms.to_json()
    elsif params[:instructor_id]

      @classrooms = Classroom.findByParentID(params[:instructor_id])

    
    elsif params[:name]

      @classrooms = Classroom.findByName(params[:name]).first
    else

      @classrooms = Classroom.all
    end
    if @classrooms != nil 
      render json: @classrooms
    end
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