class ActivitiesController < ApplicationController
  
  before_action :set_activity, only: [:show, :update, :destroy]
  

  def index

      # GET /activities?lab_session_id=34

    @activities = if params[:lab_session_id]
      Activity.search_by_lab_session_id(params[:lab_session_id])
    else
        # GET /activities

      Activity.all
    end
    @activities = @activities.title(params[:title]) if params[:title].present?
    
    render json: @activities
  end
  
  # GET /activities/21
  def show
    render json: @activity
  end
  
  # POST /activities
  def create
    @activity = Activity.new(activity_params)
    if @activity.save
      render :show, status: :created, location: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @activity.update(activity_params)
      render :show, status: :ok, location: @activity
    else 
      render json: @activity.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @activity.destroy
  end
  
  private
      def set_activity
        @activity = Activity.find(params[:id])
      end
      def activity_params
        params.require(:activity).permit(:title, :lab_session_id)
      end
end
