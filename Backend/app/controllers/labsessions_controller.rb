class LabsessionsController < ApplicationController
  
  before_action :set_labsession, only: [:show, :update, :destroy]
  
  def index

    # FIND
    @labsessions = if params[:name]
      Labsession.findByName(params[:name])
    else

      # GET ALL
      Labsession.all
    end
    render json: @labsessions
  end
  
  # GET ONE
  def show
    render json: @labsessions
  end

  # POST
  def create
    @labsessions = Labsessions.new(labsession_params)
    if @labsessions.save
      render json: @classroom.to_json(only: [:id]), status: :created
    else
      render json: @labsessions.errors, status: :unprocessable_entity
    end
  end
  
  # UPDATE
  def update
    if @labsession.update(labsession_params)
      render json: @classroom
    else 
      render json: @labsession.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE
  def destroy
    @labsession.destroy
  end
  
  private
  def set_labsession
    @labsession = Labsession.find(params[:id])
  end
  def labsession_params
    params.require(:labsession).permit(:name, :isActive, :classroom_id)
  end
end
