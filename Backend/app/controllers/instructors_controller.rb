class InstructorsController < ApplicationController    
    before_action :set_instructor, only: [:show, :update, :destroy]
    
    #GET /instructors
    def index
  
      # GET /instructors?username=helloworld
      @instructors = if params[:username]
        Instructor.findByUsername(params[:username])
      else
  
      # GET /instructors
      Instructor.all
      end
      render json: @instructors
    end
  
    # GET /instructors/1
    def show
      render json: @instructor.to_json(only: [:id, :name, :username, :password])
    end
  
    # POST /instructors
    def create
      @instructor = Instructor.new(instructor_params)
      if @instructor.save
        render json: @instructor.to_json(only: [:id]), status: :created
      else
        render json: @instructor.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /instructors/1
    def update
      if @instructor.update(instructor_params)
        render json: @instructor
      else
        render json: @instructor.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /instructors/1
    def destroy
      @instructor.destroy
    end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end
    # Only allow a trusted parameter "white list" through.
    def instructor_params
      params.fetch(:instructor).permit(:name, :username, :password)
    end
  end