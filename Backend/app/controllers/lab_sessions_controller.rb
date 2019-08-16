class LabSessionsController < ApplicationController
  
  before_action :set_labSession, only: [:show, :update, :destroy]
  
  
  def index

      # GET /labSessions?title=hello

    @labSessions = if params[:title]
      LabSession.search_by_title(params[:title])
    else
        # GET /labSessions

      LabSession.all
    end
    @labSessions = @labSessions.title(params[:title]) if params[:title].present?
    
    render json: @labSessions
  end
  
  # GET /labSessions/23
  def show
    render json: @labSession
  end

  # POST /labSessions
  def create
    @labSession = LabSession.new(labSession_params)
    if @labSession.save
      render :show, status: :created, location: @labSession
    else
      render json: @labSession.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @labSession.update(labSession_params)
      render :show, status: :ok, location: @labSession
    else 
      render json: @labSession.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @labSession.destroy
  end
  
  private
      def set_labSession
        @labSession = LabSession.find(params[:id])
      end
      def labSession_params
        params.require(:lab_session).permit(:title, :finished, :draft)
      end
end
