class SessionsController < ApplicationController
  
  before_action :set_session, only: [:show, :update, :destroy]
  
  def index

    # FIND
    @sessions = if params[:name]
      Session.findByName(params[:name])
    else

      # GET ALL
      Session.all
    end
    render json: @sessions
  end
  
  # GET ONE
  def show
    render json: @session
  end

  # POST
  def create
    @session = Session.new(session_params)
    if @session.save
      render json: @session.to_json(only: [:id]), status: :created
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end
  
  # UPDATE
  def update
    if @session.update(session_params)
      render json: @session
    else 
      render json: @session.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE
  def destroy
    @session.destroy
  end
  
  private
  def set_session
    @session = Session.find(params[:id])
  end
  def session_params
    params.require(:session).permit(:name, :isActive, :classroom_id)
  end
end
