class SessionsController < ApplicationController
  
  before_action :set_session, only: [:show, :update, :destroy]

  def index

    @sessions = Session.all
    if params[:classroom_id]
      @sessions = Session.findByParentID(params[:classroom_id])
    end

    # FIND
    if params[:name]
      @sessions = @sessions.findByName(params[:name])
    end

    render json: @sessions
  end
  
  # GET ONE
  def show
    render json: @session
  end

  # POST
  def create
    @session = if params[:classroom_id]
      @session = @classroom.sessions.build(session_params)
      if @session.save
        render json: @session.to_json(only: [:id]), status: :created
      else
        render json: @session.errors, status: :unprocessable_entity
      end
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
