class ClassroomsController < ApplicationController    
  before_action :set_classroom, only: [:show, :update, :destroy]
  
  #GET /classrooms
  def index

    # GET /classrooms?name=helloworld
    @classrooms = if params[:name]
      Classroom.findByName(params[:name])
    else

    # GET /classrooms
    Classroom.all
    end
    render json: @classrooms
  end

  # GET /classrooms/1
  def show
    render json: @classroom.to_json(only: [:id, :name])
  end

  # POST /classrooms
  def create
    @classroom = Classroom.new(classroom_params)
    if @classroom.save
      render json: @classroom.to_json(only: [:id]), status: :created
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /classrooms/1
  def update
    if @classroom.update(classroom_params)
      render json: @classroom
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  # DELETE /classrooms/1
  def destroy
    @classroom.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_classroom
    @classroom = Classroom.find(params[:id])
  end
  # Only allow a trusted parameter "white list" through.
  def classroom_params
    params.fetch(:classroom).permit(:name, :instructor_id)
  end
end