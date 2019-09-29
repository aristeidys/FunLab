class ClassroomsController < ApplicationController   

  before_action :set_classroom, only: [:show, :update, :destroy]
  before_action :get_instructor, only: [:show, :create]
  
  def index

    @classrooms = if params[:instructor_id]
      @instructor.classrooms
    else

      # GET ALL
      Classroom.all
    end 
    
    # FIND
    if params[:name]
      @classrooms = @classrooms.findByName(params[:name])
    end


    render json: @classrooms
  end

  # GET ONE
  def show
    render json: @classroom.to_json()
  end

  # POST
  def create
    @classrooms = if params[:instructor_id]
      @classroom = @instructor.classrooms.build(classroom_params)

      if @classroom.save
        render json: @classroom.to_json(), status: :created
      else
        render json: @classroom.errors, status: :unprocessable_entity
      end
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
  def get_instructor
    if params[:instructor_id]
      @instructor = Instructor.find(params[:instructor_id])
    end
  end
end