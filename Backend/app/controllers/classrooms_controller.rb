class ClassroomsController < ApplicationController   

  before_action :set_classroom, only: [:show, :update, :destroy]
  
  def index

    # FIND
    @classrooms = if params[:name]
      Classroom.findByName(params[:name])
    else

    # GET ALL
    Classroom.all
    end
    render json: @classrooms
  end

  # GET ONE
  def show
    render json: @classroom.to_json(only: [:id, :name])
  end

  # POST
  def create
    @classroom = Classroom.new(classroom_params)
    if @classroom.save
      render json: @classroom.to_json(only: [:id]), status: :created
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