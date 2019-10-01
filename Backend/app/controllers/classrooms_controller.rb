class ClassroomsController < ApplicationController   

  before_action :set_classroom, only: [:show, :update, :destroy]
  
  def index

    @classrooms = Classroom.all
    if params[:instructor_id]
      @classrooms = Classroom.findByParentID(params[:instructor_id])
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
end