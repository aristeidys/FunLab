class SessionsController < ApplicationController
  
  before_action :set_session, only: [:show, :update, :destroy]
  
  
  def index

      # GET /sessions?title=hello

    @sessions = if params[:title]
      Session.search_by_title(params[:title])
    else
        # GET /sessions

      Session.all
    end
    @sessions = @sessions.findByTitle(params[:title]) if params[:title].present?
    
    render json: @sessions
  end
  
  # GET /sessions/23
  def show
    render json: @sessions
  end

  # POST /sessions
  def create
    @sessions = Sessions.new(session_params)
    if @sessions.save
      render :show, status: :created, location: @session
    else
      render json: @sessions.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @session.update(session_params)
      render :show, status: :ok, location: @session
    else 
      render json: @session.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @session.destroy
  end
  
  private
      def set_session
        @session = Session.find(params[:id])
      end
      def session_params
        params.require(:session).permit(:title, :finished, :draft)
      end
end
